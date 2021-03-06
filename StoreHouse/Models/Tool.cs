//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace StoreHouse.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Tool
    {
        public Tool()
        {
            this.Audits = new HashSet<Audit>();
            this.DeletedTools = new HashSet<DeletedTool>();
            this.ToolsUses = new HashSet<ToolsUs>();
            this.WriteOffTools = new HashSet<WriteOffTool>();
        }
    
        public int ToolID { get; set; }
        public int CategoryID { get; set; }
        public string Name { get; set; }
        public int Count { get; set; }
        public int Cell { get; set; }
        public Nullable<bool> IsDeleted { get; set; }
        public System.DateTime CreationDate { get; set; }
        public Nullable<int> LowCount { get; set; }
        public Nullable<int> LowerCount { get; set; }
    
        public virtual ICollection<Audit> Audits { get; set; }
        public virtual Category Category { get; set; }
        public virtual ICollection<DeletedTool> DeletedTools { get; set; }
        public virtual ICollection<ToolsUs> ToolsUses { get; set; }
        public virtual ICollection<WriteOffTool> WriteOffTools { get; set; }
    }
}
