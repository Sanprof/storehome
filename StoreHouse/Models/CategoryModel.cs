﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StoreHouse.Models
{
    public class UpdateCategoryModel: TokenBase
    {
        public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public int cellfrom { get; set; }
        public int cellto { get; set; }
    }
}