using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StoreHouse.Models
{
    public class ToolsInCategoryModel : TokenBase
    {
        public int id { get; set; }
    }

    public class UpdateToolModel : TokenBase
    {
        public int id { get; set; }
        public string name { get; set; }
        public int count { get; set; }

        public int cell { get; set; }
    }

    public class WriteOffModel : SimpleDeleteModel
    {
        public int count { get; set; }

        public string comment { get; set; }
    }

    public class IncIssueModel : TokenBase
    {
        public int id { get; set; }
        public bool isinc { get; set; }
        public int count { get; set; }
        public int workerid { get; set; }
    }
}