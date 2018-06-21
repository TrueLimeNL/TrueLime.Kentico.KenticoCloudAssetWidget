using KenticoCloud.ContentManagement.Models.Assets;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace $rootnamespace$.Repositories
{
    public interface IAssetRepository : IRepository
    {
        Task<List<AssetModel>> GetAssets(string apiKey, string projectId);
    }
}