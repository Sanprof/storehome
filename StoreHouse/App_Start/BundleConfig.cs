using System.Web;
using System.Web.Optimization;

namespace StoreHouse
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/knockout").Include(
                        "~/Scripts/knockout/knockout-{version}.js",
                        "~/Scripts/knockout/knockout.mapping.js",
                        "~/Scripts/knockout/knockout.validation.js",
                        "~/Scripts/knockout/koExternalTemplateEngine_all.js"));

            bundles.Add(new ScriptBundle("~/bundles/admin").Include(
                "~/Scripts/bootstrap/bootstrap.js",
                "~/Scripts/bootstrap/bootstrap-growl.js",
                "~/Scripts/bootstrap/bootstrap3-typeahead.js",
                "~/Scripts/bootstrap/metisMenu.js"));

            bundles.Add(new ScriptBundle("~/bundles/model").Include(
                "~/Scripts/model/Utils.js",
                "~/Scripts/model/DateUtils.js",
                "~/Scripts/model/CookieManager.js",
                "~/Scripts/model/Confirmation.js",
                "~/Scripts/model/Constants.js",
                "~/Scripts/model/koCustomBindings.js",
                "~/Scripts/model/koExtenders.js",
                "~/Scripts/model/Alerts.js",
                "~/Scripts/model/TextJournals.js",
                "~/Scripts/model/MasterModel.js",
                "~/Scripts/model/BaseObject.js",
                "~/Scripts/model/Newable.js",
                "~/Scripts/model/StringFormatter.js",
                "~/Scripts/model/StartPageManager.js",
                "~/Scripts/model/StartPageItem.js",

                "~/Scripts/model/Manager.js",
                "~/Scripts/model/DescrName.js",
                "~/Scripts/model/Eventable.js",
                "~/Scripts/model/EventItem.js",
                "~/Scripts/model/PartialListManager.js",
                "~/Scripts/model/Sortable.js",
                "~/Scripts/model/SortableHeader.js",
                "~/Scripts/model/TablePager.js",
                "~/Scripts/model/WorkerManager.js",
                "~/Scripts/model/Worker.js",
                "~/Scripts/model/ToolsControlManager.js",
                "~/Scripts/model/toolsmanager.js",
                "~/Scripts/model/CategoryManager.js",
                "~/Scripts/model/Category.js",
                "~/Scripts/model/Tool.js",
                "~/Scripts/model/PositionManager.js",
                "~/Scripts/model/Position.js",
                "~/Scripts/model/WriteOffManager.js",
                "~/Scripts/model/LoginUser.js"));

            bundles.Add(new ScriptBundle("~/bundles/auth").Include(
                "~/Scripts/model/BaseObject.js",
                "~/Scripts/model/Utils.js",
                "~/Scripts/model/CookieManager.js",
                "~/Scripts/model/LoginUser.js",
                "~/Scripts/model/koCustomBindings.js",
                "~/Scripts/model/koExtenders.js",
                "~/Scripts/model/Alerts.js",
                "~/Scripts/model/TextJournals.js"));

            bundles.Add(new StyleBundle("~/Content/sbadmin").Include(
                "~/Content/animate.css",
                "~/Content/bootstrap.css",
                "~/Content/font-awesome/font-awesome.css",
                "~/Content/sb-admin-2.css"));

            bundles.Add(new StyleBundle("~/Content/auth").Include(
                "~/Content/auth.css"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                "~/Content/Site.css"));

            // Set EnableOptimizations to false for debugging. For more information,
            // visit http://go.microsoft.com/fwlink/?LinkId=301862
            BundleTable.EnableOptimizations = false;
        }
    }
}