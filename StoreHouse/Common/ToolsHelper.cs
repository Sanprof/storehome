using System.Dynamic;
using System.Linq;

namespace StoreHouse.Common
{
    public static class ToolsHelper
    {
        public static int ToolStat(Models.Entities store)
        {
            var toolsUses = store
                .ToolsUses
                .Select(it => it.Count)
                .ToList();
            if (toolsUses.Count > 0)
                return toolsUses.Sum();
            return 0;
        }

        public static int ToolStatByToolID(Models.Entities store, int toolID)
        {
            var toolsUses = store
                .ToolsUses
                .Where(it => it.ToolID == toolID)
                .Select(it => it.Count)
                .ToList();
            if (toolsUses.Count > 0)
                return toolsUses.Sum();
            return 0;
        }

        public static int ToolStatByToolIDWorkerID(Models.Entities store, int toolID, int workerID)
        {
            var toolsUses = store
                .ToolsUses
                .Where(it => it.ToolID == toolID && it.WorkerID == workerID)
                .Select(it => it.Count)
                .ToList();
            if (toolsUses.Count > 0)
                return toolsUses.Sum();
            return 0;
        }

        public static int ToolStatByWorkerID(Models.Entities store, int workerID)
        {
            var toolsUses = store
                .ToolsUses
                .Where(it => it.WorkerID == workerID)
                .Select(it => it.Count)
                .ToList();
            if (toolsUses.Count > 0)
                return toolsUses.Sum();
            return 0;
        }
    }
}