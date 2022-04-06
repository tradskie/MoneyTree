//
//  AppRouter.swift
//  MoneyTree
//
//  Created by Jack Xiong Lim on 5/4/22.
//

import Foundation
import RxCocoa
import RxSwift

enum RoutingType {
    case push(viewControllers: [UIViewController], popCurrentViewController: Bool)
    case present(viewController: UIViewController, completion: (() -> Void)? = nil)
    case popTo
}

typealias NavigationParams<T: UIViewController> = (routingType: RoutingType, latestViewControllerInstance: T.Type, animated: Bool)

open class AppRouter {
    var navigationController: UINavigationController?
    var navigationRelay = PublishRelay<NavigationParams>()
    private(set) var disposeBag = DisposeBag()
    init() {
        navigationRelay
            .observe(on: MainScheduler.instance)
            .throttle(.milliseconds(500),
                      scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] params in
                guard let strongSelf = self else { return }
                
                switch params.routingType {
                case .push, .popTo:
                    strongSelf.pushViewControllers(routingType: params.routingType, onExisting: params.latestViewControllerInstance, animated: params.animated)
                case .present(let viewController, let completion):
                    if let topViewController = strongSelf.navigationController?.topViewController?.topMostPresentedViewController() ?? strongSelf.navigationController?.topViewController {
                        viewController.modalPresentationStyle = .fullScreen
                        topViewController.present(viewController, animated: params.animated, completion: completion)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    open class func sharedInstance() -> AppRouter {
        struct __ { static let _sharedInstance = AppRouter() }
        return __._sharedInstance
    }
    
    func pop(animated: Bool = true) {
        guard let navigationController = self.navigationController else { return }
        guard navigationController.viewControllers.count > 1 else { return }
        let secondTopViewController = navigationController.viewControllers[navigationController.viewControllers.count - 2]
        let params: NavigationParams = (.popTo, type(of: secondTopViewController), animated)
        navigationRelay.accept(params)
    }
    
    func navigateTo(_ viewController: UIViewController, animated: Bool = true, popCurrentViewController: Bool = false) {
        guard let topViewController = navigationController?.topViewController else { return }
        let params: NavigationParams = (.push(viewControllers: [viewController], popCurrentViewController: popCurrentViewController), type(of: topViewController), animated)
        navigationRelay.accept(params)
    }
    
    func navigateTo(_ viewControllers: [UIViewController], animated: Bool) {
        guard let topViewController = navigationController?.topViewController else { return }
        let params: NavigationParams = (.push(viewControllers: viewControllers, popCurrentViewController: false), type(of: topViewController), animated)
        navigationRelay.accept(params)
    }
    
    func present(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let topViewController = navigationController?.topViewController else { return }
        let params: NavigationParams = (.present(viewController: viewController, completion: completion), type(of: topViewController), animated)
        navigationRelay.accept(params)
    }
    
    // MARK: - Private API -
    
    private func pushViewControllers<T>(routingType: RoutingType, onExisting viewControllerType: T.Type, animated: Bool) where T: UIViewController {
        guard let navigationController = self.navigationController else { return }
        var dashboardIndex: Int = NSNotFound
        
        for (index, viewController) in navigationController.viewControllers.enumerated() where type(of: viewController) == viewControllerType {
            dashboardIndex = index
        }
        
        if dashboardIndex != NSNotFound {
            var newViewControllers = Array(navigationController.viewControllers[...dashboardIndex])
            
            switch routingType {
            case .push(let viewControllers, let popCurrentViewController):
                if popCurrentViewController {
                    _ = newViewControllers.popLast()
                }
                newViewControllers.append(contentsOf: viewControllers)
                navigationController.setViewControllers(newViewControllers, animated: animated)
            case .popTo:
                navigationController.setViewControllers(newViewControllers, animated: animated)
            default:
                break
            }
        }
    }
    
}
