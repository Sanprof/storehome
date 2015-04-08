using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StoreHouse.Models
{
    public class UpdateWorkerModel : TokenBase
    {
        public int id { get; set; }
        public string firstname { get; set; }
        public string lastname { get; set; }
        public string middlename { get; set; }
        public int positionid { get; set; }
    }
}