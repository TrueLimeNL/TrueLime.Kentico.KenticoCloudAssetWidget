using KenticoCloud.ContentManagement;
using KenticoCloud.ContentManagement.Models;
using KenticoCloud.ContentManagement.Models.Assets;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace $rootnamespace$.Repositories.Implementation
{
    /// <summary>
    /// Represents a collection of assets.
    /// </summary>
    public class KenticoCloudAssetRepository : IAssetRepository
    {
        private readonly string mCultureName;
        private readonly bool mLatestVersionEnabled;

        public KenticoCloudAssetRepository(string cultureName, bool latestVersionEnabled)
        {
            mCultureName = cultureName;
            mLatestVersionEnabled = latestVersionEnabled;
        }

        public async Task<List<AssetModel>> GetAssets(string apiKey, string projectId)
        {
            ContentManagementOptions options = new ContentManagementOptions
            {
                ApiKey = apiKey,
                ProjectId = projectId
            };

            ContentManagementClient client = new ContentManagementClient(options);
            ListingResponseModel<AssetModel> response = await client.ListAssetsAsync();
          
            return response.ToList();
        }  
    }
}