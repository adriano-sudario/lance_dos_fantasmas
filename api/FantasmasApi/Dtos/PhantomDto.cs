namespace FantasmasApi.Dtos
{
    public class PhantomDto
    {
        public float environment_index { get; set; }
        public float x { get; set; }
        public float y { get; set; }
        public float image_xscale { get; set; }
        public float image_yscale { get; set; }
        public float image_angle { get; set; }
        public float image_index { get; set; }
        public float image_blend { get; set; }
        public PathDto[] path { get; set; }
    }

    public class PathDto
    {
        public float environment_index { get; set; }
        public float x { get; set; }
        public float y { get; set; }
        public float image_xscale { get; set; }
        public float image_yscale { get; set; }
        public float image_angle { get; set; }
        public float audio_time { get; set; }
    }
}
