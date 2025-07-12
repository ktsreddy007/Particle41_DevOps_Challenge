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

app.Use(async (context, next) =>
{
    Console.WriteLine($"[DEBUG] Incoming request to: {context.Request.Path}");
    await next();
});

app.MapControllers();
app.Run("http://0.0.0.0:5000");
// Accessible at: http://localhost:5000/
