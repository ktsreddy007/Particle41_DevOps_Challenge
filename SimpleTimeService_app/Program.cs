var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Logging.ClearProviders();
builder.Logging.AddConsole();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}

var isAzureContainerApp = Environment.GetEnvironmentVariable("WEBSITE_SITE_NAME") != null;

Console.WriteLine("[Startup] SimpleTimeService has started.");

if (isAzureContainerApp)
{
    Console.WriteLine("[Azure Startup] Image pulled from DockerHub and running inside Azure Container App.");
}
else
{
    Console.WriteLine("[Local Startup] Running locally — not in Azure Container App.");
}

Console.WriteLine("Listening on http://0.0.0.0:5000");

app.MapGet("/weatherforecast", () =>
{
    var summaries = new[] { "Freezing", "Chilly", "Mild", "Warm", "Hot" };
    return Enumerable.Range(1, 5).Select(index => new WeatherForecast
    (
        DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
        Random.Shared.Next(-20, 55),
        summaries[Random.Shared.Next(summaries.Length)]
    )).ToArray();
});

app.Use(async (context, next) =>
{
    Console.WriteLine($"[DEBUG] Incoming request to: {context.Request.Path}");
    await next();
});

app.MapControllers();
app.Run("http://0.0.0.0:5000");

// Accessible at: http://localhost:5000/
record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}