using Microsoft.AspNetCore.Mvc;
using System;
using System.Net;
using System.Runtime.InteropServices;

namespace SimpleTimeService.Controllers
{
    [ApiController]
    public class TimeController : ControllerBase
    {
        [HttpGet("/")]
        public IActionResult GetTime()
        {
            // Use null-conditional operator to avoid null dereference
            var ip = Request.HttpContext.Connection.RemoteIpAddress?.ToString() ?? "Unknown IP";
            string timeZoneId = RuntimeInformation.IsOSPlatform(OSPlatform.Windows) ? 
                    "India Standard Time" : 
                    "Asia/Kolkata";
            TimeZoneInfo timeZoneInfo = TimeZoneInfo.FindSystemTimeZoneById(timeZoneId); 
            DateTime localTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, timeZoneInfo);
            var timestamp = localTime.ToString("yyyy-MM-dd HH:mm:ss");
            Console.WriteLine($"Responding with timestamp: {timestamp}, IP: {ip}");
            return Ok(new { timestamp, ip });
        }
    }
}