using FantasmasApi.Dtos;
using System.Collections.Generic;
using System.IO;
using System.Text.Json;

namespace FantasmasApi.Services
{
    public class PhantomService
    {
        private readonly string fileName = "previous_phantoms.json";

        public List<PhantomDto> GetPhantoms()
        {
            if (!File.Exists(fileName))
                return new List<PhantomDto>();

            using (var fileStream = File.OpenRead(fileName))
            using (var textReader = new StreamReader(fileStream))
                return JsonSerializer.Deserialize<List<PhantomDto>>(
                    textReader.ReadToEnd());
        }

        public void InsertPhantom(PhantomDto phantom)
        {
            var phantoms = GetPhantoms();

            if (phantoms.Count > 9)
                phantoms.RemoveRange(0, phantoms.Count - 9);

            phantoms.Add(phantom);

            using (var fileStream = File.OpenWrite(fileName))
            using (var textWriter = new StreamWriter(fileStream))
                textWriter.Write(JsonSerializer.Serialize(phantoms));
        }
    }
}
