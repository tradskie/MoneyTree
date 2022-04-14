## Table of contents
* [General info](#general-info)
* [Setup](#setup)
* [Design](#design)
* [Module](#module)

## General info
This project is an assignment for MoneyTree's interview.

## Setup
To run this project, make sure to have Cocoapods installed, then go to the project's root folder and run

```
$ pod install
```

## Design
The project is built with MVVM in mind as a base, with a CLEAN module backing it up.
Reason for this decision is, as project / requirement grows, the VM itself is bloated, hence adding a CLEAN to offload the VM.

## Module
A module consists of
- View Controller - The standard View Controller from MVC, responsible to loading the view / lifecycles, also subscriptions to VM
- View - View to be loaded into the VC, subviews are created here then constraints are activated
- Interactor - Network call management, if success, it'll pass the model (decalred in Models) to the Presenter
- Interfaces - Protocols to be defined to be used. BusinessLogic for Interactor, Presentable for Presenter, Displayable for VM
- Models - Model declarations for Interactor and presenter to be used
- ViewModel - Relays etc declared so VC can subscribe
- Presenter - Receive json object from Interactor and massage it to be passed to VM
- Section - Setup for potential tableView / collectionview

## Limitation
Since the assignment mentioned that long term network calls are expected, I moved ahead and implemented the network calls to further demonstrate the architecture proposed. Of course this comes with one problem, since by default I should be calling something like `/accounts/\(id)/transactions`, but since the current jsons are mocked from a third party, the URL is generated, hence I just went and choose the account with the most transaction (account id 2) to demonstrate, which resulted into a bug that presents the same transation list for every account.
Due to time constraint from my end, I only managed to complete 2 stories, would be interested to further attempt the rest.