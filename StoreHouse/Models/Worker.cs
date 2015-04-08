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
    
    public partial class Worker
    {
        public Worker()
        {
            this.DeletedTools = new HashSet<DeletedTool>();
            this.UserSessions = new HashSet<UserSession>();
            this.Users = new HashSet<User>();
            this.WriteOffTools = new HashSet<WriteOffTool>();
            this.ToolsUses = new HashSet<ToolsUs>();
            this.ToolsUses1 = new HashSet<ToolsUs>();
        }
    
        public int WorkerID { get; set; }
        public int PositionID { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public Nullable<bool> IsDeleted { get; set; }
        public System.DateTime CreationDate { get; set; }
    
        public virtual ICollection<DeletedTool> DeletedTools { get; set; }
        public virtual Position Position { get; set; }
        public virtual ICollection<UserSession> UserSessions { get; set; }
        public virtual ICollection<User> Users { get; set; }
        public virtual ICollection<WriteOffTool> WriteOffTools { get; set; }
        public virtual ICollection<ToolsUs> ToolsUses { get; set; }
        public virtual ICollection<ToolsUs> ToolsUses1 { get; set; }
    }
}