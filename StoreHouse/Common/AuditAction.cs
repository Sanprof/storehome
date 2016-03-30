using System.ComponentModel;

namespace StoreHouse.Common
{
    public enum ToolAction
    {
        [Description("Добавление инструмента(ов)")]
        Add = 1,
        [Description("Выдача инструмента(ов)")]
        Issue = 2,
        [Description("Прием инструмента(ов)")]
        Take = 3,
        [Description("Списание инструмента(ов)")]
        WriteOff = 4,
    }

    public enum AuditShowFilter
    {
        All = 0,
        OnlyNew = 1,
        OnlyReaded = 2,
    }
}