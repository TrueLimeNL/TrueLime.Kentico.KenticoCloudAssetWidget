# TrueLime.Kentico.KenticoCloudAssetWidget

Contains a widget to select and display a Kentico Cloud asset. 

## Installation
In Controllers\Widgets\KenticoCloudAssetWidgetController.cs update the ApiKey and ProjectId.

Add the widget namespace to the list of area restrictions to be able to place the widget on the desired pages.

*Note: Depending on where your data is hosted you will need to update the GetAssetUrl method with the corresponding data center Url:*
- US: https://assets-us-01.kc-usercontent.com
- EU: https://assets-eu-01.kc-usercontent.com

## Requirements
- Works with Kentico v12.
- This project references the KenticoCloud.ContentManagement API which requires .NET Standard version 2.0. You need to ensure that the project targets the 4.6.1 (or newer) .NET Framework.