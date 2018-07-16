//
//  Extensions.swift
//  FlairPit
//
//  Created by Haseeb Saad on 25/12/2016.
//  Copyright © 2016 Haseeb Saad. All rights reserved.
//

import UIKit

import UserNotifications

import AVFoundation


// MARK: - UIViewController
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        slideDown.direction = .down
        view.addGestureRecognizer(slideDown)
        
        let slideUp = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        slideUp.direction = .up
        view.addGestureRecognizer(slideUp)
        
        
        
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func showAlertwith(title: String?, message: String?, buttonTitle: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: buttonTitle ?? "Okay", style: .default, handler: { (action) in
            //self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
    func showAlertWithCompletionHandler(title: String?, message: String?, buttonTitle: String?, completion: @escaping ()->()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: buttonTitle ?? "Okay", style: .default, handler: { (action) in
            //self.dismiss(animated: true, completion: nil)
            completion()
        })
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
    func showAlertWithCancelAndCompletion(title: String?, message: String?, buttonTitle: String?, completionForContinue: @escaping ()->(), completionForCancel: @escaping ()->()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            completionForCancel()
        }
        alert.addAction(cancelAction)
        
        let okayAction = UIAlertAction(title: buttonTitle ?? "Okay", style: .default, handler: { (action) in
            //self.dismiss(animated: true, completion: nil)
            completionForContinue()
        })
        alert.addAction(okayAction)
        
        present(alert, animated: true, completion: nil)
    }
    func makeImageRound(image: UIImageView, withBorderColor: CGColor, borderWidth: CGFloat?){
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        image.layer.borderWidth = borderWidth ?? 3.0
        image.layer.borderColor = withBorderColor
    }
}

// MArK: - NSAttributed String
extension NSMutableAttributedString {
    @discardableResult func bold(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedStringKey:Any] = [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Medium", size: 14)!]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}

// MARK: - UIView
extension UIView {
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func addShadowOnView(){
        
        self.layer.shadowRadius = 2.5
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false

        
    }
    
    func addGradientEffect(color: CGColor, view: UIView, gradientPosition: NSNumber, gradientAmount: NSNumber){
        
        let gradient = CAGradientLayer()
        
        gradient.frame = view.frame
        
        gradient.colors = [UIColor.clear.cgColor, color]
        
        gradient.locations = [gradientPosition, gradientAmount]
        
        
        view.layer.addSublayer(gradient)
        
        
    }
    
    
    
    
    public  func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    public  func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
    
    
    
    
    
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0,y: 0, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width,y: 0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.height - width, width:self.frame.width, height:width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func loadingIndicator(show: Bool){
        let tag = 9876
        if show {
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            DispatchQueue.main.async {
                indicator.startAnimating()
            }
        } else {
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                DispatchQueue.main.async {
                    indicator.stopAnimating()
                }
                indicator.removeFromSuperview()
            }
        }
  
    }
    
    func loadingIndicatorWithDarkColor(show: Bool){
        let tag = 9876
        if show {
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            indicator.color = .darkGray
            self.addSubview(indicator)
            DispatchQueue.main.async {
                indicator.startAnimating()
            }
        } else {
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                DispatchQueue.main.async {
                    indicator.stopAnimating()
                }
                indicator.removeFromSuperview()
            }
        }
        
    }
    
    func fadeIn(withDuration: TimeInterval = 1.0, completion: @escaping (Bool)-> Void = {_ in }) {
        // Move our fade out code from earlier
        UIView.animate(withDuration: withDuration, delay: 0.3, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: completion)
    }
    
    func fadeOut(withDuration: TimeInterval = 1.0, completion: @escaping (Bool)-> Void = {_ in }) {
        UIView.animate(withDuration: withDuration, delay: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { (_) in
            
            self.alpha = 1.0
        })
        
    }
    
    
    func roundedBottomLeftView(){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.bottomLeft,.bottomRight],
                                     cornerRadii:CGSize(width: 3.0, height: 0.0))
        
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
        
    }
   
    
    
}

// MARK: - UIButton
extension UIButton {
    
     func addShadowOnButton(){
        
        self.layer.shadowRadius = 3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    func loadingIndicatorWithText(show: Bool, text: String = "") -> String? {
        let originalText = self.currentTitle
        DispatchQueue.main.async {
            self.setTitle(text, for: .normal)
            super.loadingIndicator(show: show)
        }
        return originalText
    }
  
  
        @objc func set(image: UIImage?, title: String, titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
            imageView?.contentMode = .center
            setImage(image, for: state)
            
            positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
            
            titleLabel?.contentMode = .center
            setTitle(title, for: state)
        }
        
    
        @objc func set(image: UIImage?, attributedTitle title: NSAttributedString, at position: UIViewContentMode, width spacing: CGFloat, state: UIControlState){
            imageView?.contentMode = .center
            setImage(image, for: state)
            
            adjust(title: title, at: position, with: spacing)
            
            titleLabel?.contentMode = .center
            setAttributedTitle(title, for: state)
        }
        
        
        // MARK: Private Methods
        
        private func adjust(title: NSAttributedString, at position: UIViewContentMode, with spacing: CGFloat) {
            let imageRect: CGRect = self.imageRect(forContentRect: frame)
            let titleSize = title.size()
            
            arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
        }
        
        private func adjust(title: NSString, at position: UIViewContentMode, with spacing: CGFloat) {
            let imageRect: CGRect = self.imageRect(forContentRect: frame)
            
            // Use predefined font, otherwise use the default
            let titleFont: UIFont = titleLabel?.font ?? UIFont()
            let titleSize: CGSize = title.size(withAttributes: [NSAttributedStringKey.font: titleFont])
            
            arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
        }
        
        private func positionLabelRespectToImage(title: String, position: UIViewContentMode, spacing: CGFloat) {
            let imageRect: CGRect = self.imageRect(forContentRect: frame)
            
            // Use predefined font, otherwise use the default
            let titleFont: UIFont = titleLabel?.font ?? UIFont()
            let titleSize: CGSize = title.size(withAttributes: [NSAttributedStringKey.font: titleFont])
            
            arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
        }
        
        private func arrange(titleSize: CGSize, imageRect:CGRect, atPosition position: UIViewContentMode, withSpacing spacing: CGFloat) {
            var titleInsets: UIEdgeInsets
            var imageInsets: UIEdgeInsets
            
            switch (position) {
            case .top:
                titleInsets = UIEdgeInsets(top: -(imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            case .bottom:
                titleInsets = UIEdgeInsets(top: (imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            case .left:
                titleInsets = UIEdgeInsets(top: 0, left: -(imageRect.width * 2), bottom: 0, right: 0)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
            case .right:
                titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            default:
                titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            
            titleEdgeInsets = titleInsets
            imageEdgeInsets = imageInsets
        }
    
    
    
}


// MARK: - UIImageView
extension UIImageView {
    
    func addShadowOnImageView(isRounded: Bool){
        if isRounded{
            self.layer.cornerRadius = self.frame.height/2
            self.clipsToBounds = true
            self.layer.shadowRadius = 1.5
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            self.layer.shadowOpacity = 0.5
            self.layer.masksToBounds = false
        }
        else
        {
            self.layer.shadowRadius = 1.5
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            self.layer.shadowOpacity = 0.5
            self.layer.masksToBounds = false
        }
        
    }
    
    func makeRound(hasBorder: Bool = false){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        if hasBorder{
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    
}
// MARK: - UIImage
extension UIImage {
    
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(self.cgImage!, in: newRect)
            let newImage = UIImage(cgImage: context.makeImage()!)
            UIGraphicsEndImageContext()
            return newImage
        }
        return nil
    }
}


// MARK: - Date ~ String Conversion
extension Date {
    func getTimeStamp() -> Int {
        return Int(self.timeIntervalSince1970 * 1000)
    }
    
    func getTimeAgo() -> String {
        
        let currentTime = Date()
        let dif = currentTime.timeIntervalSince(self)
        
        let minute = 60
        let hour = minute * 60
        let day = hour * 24
        let week = day * 7
        let difInInt = Int(dif.rounded())
        
        switch difInInt{
        case 0..<minute:
            return("\(difInInt)s")
        case minute..<hour:
            return("\(difInInt/minute)m")
        case hour..<day:
            return("\(difInInt/hour)h")
        case day..<week:
            return("\(difInInt/day)d")
        default:
            return("\(difInInt/week)w")
        }
    }
    
    func getTime() -> String {
        let date = self
        let calendar = Calendar(identifier: .gregorian)
        //let formatter = DateFormatter()
        var dc = DateComponents()
        dc.calendar = Calendar.current
        let unitFlags:Set<Calendar.Component> = [
            .hour, .day, .month,
            .year,.minute,.hour,.second,.weekday,
            .calendar]
        dc = Calendar.current.dateComponents(unitFlags, from: date)
        if calendar.isDateInToday(date) {
            let hour   = dc.hour!
            let minute = dc.minute!
            return "\(hour):\(minute)"
        }
        else if calendar.isDateInWeekend(date) {
            let day = dc.weekday!
            switch day {
            case 0:
                return "Sun"
            case 1:
                return "Mon"
            case 2:
                return "Tue"
            case 3:
                return "Wed"
            case 4:
                return "Thu"
            case 5:
                return "Fri"
            case 6:
                return "Sat"
            default:
                return ""
            }
        }
        else {
            let _date = dc.day!
            let month = dc.month!
            switch month {
            case 0:
                return "\(_date) " + "Jan"
            case 1:
                return "\(_date) " + "Feb"
            case 2:
                return "\(_date) " + "Mar"
            case 3:
                return "\(_date) " + "Apr"
            case 4:
                return "\(_date) " + "Mar"
            case 5:
                return "\(_date) " + "Jun"
            case 6:
                return "\(_date) " + "Jul"
            case 7:
                return "\(_date) " + "Aug"
            case 8:
                return "\(_date) " + "Sep"
            case 9:
                return "\(_date) " + "Oct"
            case 10:
                return "\(_date) " + "Nov"
            case 11:
                return "\(_date) " + "Dec"
            default:
                return ""
            }
        }
    }
    
    init(timeStamp: Int) {
        let timeInterval = Double(timeStamp / 1000)
        self.init(timeIntervalSince1970: timeInterval)
    }

}

// MARK: - Array
extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}












// MARK: - Dictionary



extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension String {
    
    
    var containsValidCharacter: Bool {
        guard self != "" else { return true }
        let hexSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789._-")
        let newSet = CharacterSet(charactersIn: self)
        return hexSet.isSuperset(of: newSet)
    }
    
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["+","0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    
    func containsNumbers() -> Bool {
        
        // check if there's a range for a number
        let range = self.rangeOfCharacter(from: .decimalDigits)
        // range will be nil if no digit is found
        if let _ = range {
            return true
        } else {
            return false
        }
        
    }
    
    func containsSpecialCharacter() -> Bool{
        
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
            
        } catch {
            debugPrint(error.localizedDescription)
            return false
        }
        
        return false
    }
    
    func containsWhiteSpace() -> Bool {
        
        // check if there's a range for a whitespace
        
        let range = self.rangeOfCharacter(from: .whitespaces)
        
        // range will be nil if no whitespace is found
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    func containsCapitalLetter() -> Bool{
        
        let range = self.rangeOfCharacter(from: .uppercaseLetters)
        
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    func containsLowerCaseLetter() -> Bool{
        
        let range = self.rangeOfCharacter(from: .lowercaseLetters)
        
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    
    func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9,// Special Characters
            0x1D000...0x1F77F,          // Emoticons
            0x2100...0x27BF,            // Misc symbols and Dingbats
            0xFE00...0xFE0F,            // Variation Selectors
            0x1F900...0x1F9FF:          // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    
}



