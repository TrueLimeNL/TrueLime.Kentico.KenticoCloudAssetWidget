@using $rootnamespace$.Models.InlineEditors
@model KenticoCloudAssetSelectorViewModel

<div data-inline-editor="kentico-cloud-asset-selector" data-property-name="@Model.PropertyName">
    @Html.DropDownList("KenticoCloudAssetSelector", Model.MediaFiles)
</div>
