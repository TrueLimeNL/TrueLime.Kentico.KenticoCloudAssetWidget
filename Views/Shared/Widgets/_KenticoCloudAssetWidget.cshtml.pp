@using $rootnamespace$.Models.InlineEditors
@model $rootnamespace$.Models.Widgets.KenticoCloudAssetWidgetViewModel

@if (Context.Kentico().PageBuilder().EditMode)
{
    Html.RenderPartial("InlineEditors/_KenticoCloudAssetSelector", new KenticoCloudAssetSelectorViewModel
    {
        PropertyName = "mediaFileGUID",
        MediaFiles = Model.Assets
    });
}

<span>@Html.Image(Model.AssetUrl)</span>