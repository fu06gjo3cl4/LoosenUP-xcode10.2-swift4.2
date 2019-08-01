## Introduction
個人的練習用專案，主要關注在專案架構。

## Environment
xcode 10.2, swift 4.2

## Project Architecture

Service : 處理網路請求以及設計全域的常用方法、常數等

UIExtensions : 以extension方式擴充常用功能，以易理解、精簡的方法名提供調用渲染介面、減少程式碼行數與重新思考時間。

RestfulService : 重構網路請求，提供callback方法參數以因應網路請求後需要調用原controller內容的情況，降低程式耦合度。

Singleton & factory & KVO : 實現全域佈景主題更新

MVVM：將介面渲染及數據更新委派給ViewModel處理，由ViewModel持有數據及介面渲染方法，View中將介面元件注入ViewModel更新。

## Real machine screen

<img align="left" src="https://github.com/fu06gjo3cl4/screenshots/blob/master/Screenshots/maincontroller.gif" width="410" height="762" />

<img align="left" src="https://github.com/fu06gjo3cl4/screenshots/blob/master/Screenshots/personal_management.gif"  />

<img align="left" src="https://github.com/fu06gjo3cl4/screenshots/blob/master/Screenshots/todetect.gif"  />

<img align="left" src="https://github.com/fu06gjo3cl4/screenshots/blob/master/Screenshots/ThemeTypeChangeDemo.gif"  />

<img align="left" src="https://github.com/fu06gjo3cl4/screenshots/blob/master/Screenshots/EditingModeForTableView.gif"  />

<img align="left" src="https://github.com/fu06gjo3cl4/screenshots/blob/master/Screenshots/SwipeableViewControllerWithToggleNavBar.gif"  />
