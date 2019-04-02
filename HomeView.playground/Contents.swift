import UIKit
import PDDFramework
import PlaygroundSupport

let bundle = Bundle(for: HomeViewController.self)
let storyboard = UIStoryboard.init(name: "Home", bundle: bundle)

let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
let homeVC = navigationController.topViewController as! HomeViewController
homeVC.viewModel = HomeViewModelFactory.create()

//Playground wrapper to check UI on all iOS devices
let (parent, _) = playgroundControllers(device: .phone5_5inch, orientation: .portrait, child: homeVC)

let frame = parent.view.frame
PlaygroundPage.current.liveView = parent
parent.view.frame = frame

