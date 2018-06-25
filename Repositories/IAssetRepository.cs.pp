using KenticoCloud.ContentManagement.Models.Assets;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace $rootnamespace$.Repositories
{
    public interface IAssetRepository : IRepository
    {
        Task<IList<AssetModel>> GetAssetsAsync(string apiKey, string projectId);
    }
}