using System.Collections.Generic;
using System.Web.Mvc;

namespace $rootnamespace$.Models.InlineEditors
{
    public class KenticoCloudAssetSelectorViewModel : InlineEditorViewModel
    {
        public IEnumerable<SelectListItem> Assets { get; set; }
    }
}