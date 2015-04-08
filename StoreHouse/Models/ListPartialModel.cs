namespace StoreHouse.Models
{
    public class ListPartialModel : TokenBase
    {
        public int psize { get; set; }
        public int pindex { get; set; }
        public ListSort sort { get; set; }
    }

    public class ListSort
    {
        public string field { get; set; }
        public bool asc { get; set; }
        public string search { get; set; }
    }
}