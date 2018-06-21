using System.Collections.Generic;
using System.Web.Mvc;

namespace $rootnamespace$.Models.Widgets
{
    public class KenticoCloudAssetWidgetViewModel
    {
        public string PropertyName { get; set; }

        public string AssetUrl { get; set; }

        public IEnumerable<SelectListItem> Assets { get; set; }
    }
}