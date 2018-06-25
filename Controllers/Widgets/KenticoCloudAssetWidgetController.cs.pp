using $rootnamespace$.Controllers.Widgets;
using $rootnamespace$.Models.Widgets;
using $rootnamespace$.Repositories;
using Kentico.PageBuilder.Web.Mvc;
using KenticoCloud.ContentManagement.Models.Assets;
using System;
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

        /// <summary>
        /// Returns a new instance of the <see cref="KenticoCloudAssetWidgetController"/> class.
        /// </summary>
        /// <param name="repository">An <see cref="IAssetRepository"/> object.</param>
        public KenticoCloudAssetWidgetController(IAssetRepository repository)
        {
            mAssetRepository = repository;
        }

        /// <summary>
        /// Returns an <see cref="ActionResult"/> object that renders the selected asset, or selection control if you are an editor.
        /// </summary>
        /// <returns>An <see cref="ActionResult"/> object that renders the selected asset, or selection control if you are an editor.</returns>
        public ActionResult Index()
        {
            var viewmodel = GetWidgetViewModel();
            return PartialView("Widgets/_KenticoCloudAssetWidget", viewmodel);
        }

        /// <summary>
        /// Returns an object that represents the widget.
        /// </summary>
        /// <returns>The object.</returns>
        private object GetWidgetViewModel()
        {
            var properties = GetProperties();
            var assets = GetAssets();
            var assetDropDownItems = GetDropDownItems(assets, properties.AssetGuid);

            var selectedAsset = GetSelectedAsset(assets, properties.AssetGuid);
            var selectedAssetUrl = GetAssetUrl(selectedAsset);

            var viewmodel = new KenticoCloudAssetWidgetViewModel
            {
                Assets = assetDropDownItems,
                AssetUrl = selectedAssetUrl
            };
            return viewmodel;
        }

        /// <summary>
        /// Returns the assets for the widget.
        /// </summary>
        /// <returns>The assets.</returns>
        private IEnumerable<AssetModel> GetAssets()
        {
            var assets = Task.Run(async () => await mAssetRepository.GetAssetsAsync(_apiKey, _projectId)).Result;
            var orderedAssets = assets.OrderBy(x => x.FileName);

            return orderedAssets.ToList();
        }

        /// <summary>
        /// Returns the selected asset.
        /// </summary>
        /// <param name="assets">The assets.</param>
        /// <param name="selectedItemGuid">Selected asset guid.</param>
        /// <returns>The asset.</returns>
        private AssetModel GetSelectedAsset(IEnumerable<AssetModel> assets, Guid selectedAssetGuid) 
            => assets.Where(x => x.Id == selectedAssetGuid).SingleOrDefault();

        /// <summary>
        /// Returns the url of the given asset.
        /// </summary>
        /// <remarks>To do: replace with API call when available</remarks>
        /// <param name="asset">The asset.</param>
        /// <returns>The url.</returns>
        private string GetAssetUrl(AssetModel asset) 
            => (asset == null) ?
                string.Empty :
                $"https://assets.kenticocloud.com/{_projectId}/{asset.Id}/{asset.FileName}";

        /// <summary>
        /// Returns the list items for the given assets.
        /// </summary>
        /// <param name="assets">The assets.</param>
        /// <param name="properties">Selected asset guid.</param>
        /// <returns>The list items.</returns>
        private IEnumerable<SelectListItem> GetDropDownItems(IEnumerable<AssetModel> assets, Guid selectedAssetGuid)
        {
            var dropdownitems = assets.Select(asset => new SelectListItem()
            {
                Text = asset.FileName,
                Value = asset.Id.ToString(),
                Selected = asset.Id == selectedAssetGuid
            });

            return dropdownitems;
        }        
    } 
}
