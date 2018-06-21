using $rootnamespace$.Controllers.Widgets;
using $rootnamespace$.Models.Widgets;
using $rootnamespace$.Repositories;
using Kentico.PageBuilder.Web.Mvc;
using KenticoCloud.ContentManagement.Models.Assets;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;

[assembly: RegisterWidget("TrueLime.Kentico.KenticoCloudAssetWidget", typeof(KenticoCloudAssetWidgetController), "KC asset", Description = "Allows you to select an asset from Kentico Cloud.", IconClass = "icon-picture")]

namespace $rootnamespace$.Controllers.Widgets
{
    public class KenticoCloudAssetWidgetController : WidgetController<KenticoCloudAssetWidgetProperties>
    {
        private readonly string _apiKey = "<YOUR_API_KEY>";
        private readonly string _projectId = "<YOUR_PROJECT_ID>";

        private readonly IAssetRepository mAssetRepository;

        public KenticoCloudAssetWidgetController(IAssetRepository repository)
        {
            mAssetRepository = repository;
        }

        public ActionResult Index()
        {
            var properties = GetProperties();

            // Get the Assets from Kentico Cloud
            var assets = Task.Run(async () => await mAssetRepository.GetAssets(_apiKey, _projectId)).Result;
            var orderedAssets = assets.OrderBy(x => x.FileName);

            // Select the asset
            var assetUrl = "";
            var selectedAsset = assets.Where(x => x.Id == properties.MediaFileGuid).SingleOrDefault();
            if (selectedAsset != null)
            {
                assetUrl = $"https://assets.kenticocloud.com/{_projectId}/{selectedAsset.Id}/{selectedAsset.FileName}";
            }

            return PartialView("Widgets/_KenticoCloudAssetWidget", new KenticoCloudAssetWidgetViewModel
            {
                Assets = PopulateListItems(orderedAssets, properties),
                AssetUrl = assetUrl
            });
        }
        private IEnumerable<SelectListItem> PopulateListItems(IEnumerable<AssetModel> assets, KenticoCloudAssetWidgetProperties properties)
        {
            var dropdownitems = assets.Select(asset => new SelectListItem()
            {
                Text = asset.FileName,
                Value = asset.Id.ToString(),
                Selected = asset.Id == properties.MediaFileGuid
            });

            return dropdownitems;
        }        
    } 
}