using FantasmasApi.Dtos;
using FantasmasApi.Services;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace FantasmasApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PhantomController : ControllerBase
    {
        private readonly PhantomService phantomService;

        public PhantomController(PhantomService phantomService) 
            => this.phantomService = phantomService;

        [HttpGet]
        public List<PhantomDto> Get() 
            => phantomService.GetPhantoms();

        [HttpPost]
        public void Post([FromBody] PhantomDto phantom) 
            => phantomService.InsertPhantom(phantom);
    }
}
