//
//  PaiExt.swift
//  PaiExt
//
//  Created by Maxim Vialykh on 1/26/18.
//
import UIKit

public typealias KeyboardCompletion = (Bool, CGFloat) -> Void

public class KeyboardObject {
    
    let completion: KeyboardCompletion
    
    init(_ completion: @escaping KeyboardCompletion) {
        self.completion = completion
    }
    
}

public protocol KeyboardCompletionProtocol {
    func addKeyboardObserver(for observer: UIViewController, _ completion: @escaping KeyboardCompletion)
    func removeKeyboardObserver(for observer: UIViewController)
}

public final class PaiExt {
    
    static let `default` = PaiExt()
    
    public var observers: NSMapTable<NSString, KeyboardObject> = NSMapTable(keyOptions: NSPointerFunctions.Options.strongMemory, valueOptions: NSPointerFunctions.Options.strongMemory)
    
    public init() {
        let center = NotificationCenter.default
//        center.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIResponder.keyboardWillShowNotification, object: nil)
//        center.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc public func keyboardWillShow(_ notification: Notification) {
        var userInfo = notification.userInfo!
        let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        postCompletions(with: true, height: keyboardFrame.height)
    }
    
    @objc public func keyboardWillHide(_ notification: Notification) {
        postCompletions(with: false, height: 0)
    }
    
    // MARK: - Inner
    public func postCompletions(with visibility: Bool, height: CGFloat) {
        guard let enumerator = observers.objectEnumerator() else { return }
        
        enumerator.forEach {
            if let object = $0 as? KeyboardObject {
                object.completion(visibility, height)
            }
        }
    }
    
}

// MARK: - KeyboardCompletionProtocol
extension PaiExt: KeyboardCompletionProtocol {
    
    public func addKeyboardObserver(for observer: UIViewController, _ completion: @escaping (Bool, CGFloat) -> Void) {
        observers.setObject(KeyboardObject(completion), forKey: "\(type(of: observer))" as NSString)
    }
    
    public func removeKeyboardObserver(for observer: UIViewController) {
        observers.removeObject(forKey: "\(observer)" as NSString)
    }
    
}

// MARK: - Keyboard Observing
public extension UIViewController {
    
    func addKeyboardObserver(_ completion: @escaping (Bool, CGFloat) -> Void) {
        PaiExt.default.addKeyboardObserver(for: self, completion)
    }
    
    func removeKeyboardObserver() {
        PaiExt.default.removeKeyboardObserver(for: self)
    }
    
}

public extension UIView {
    func setBorderColor(oColor: UIColor, fBorderWidth: CGFloat) {
        self.layer.borderWidth = fBorderWidth
        self.layer.borderColor = oColor.cgColor
    }
}
