//
//  WOWClickableView.swift
//  WOWClickableView
//
//  Created by Zhou Hao on 03/11/16.
//  Copyright © 2016年 Zhou Hao. All rights reserved.
//

//
//  WOWClickableView.swift
//  WOWtv
//
//  Created by Zhou Hao on 03/11/16.
//  Copyright © 2016年 Zhou Hao. All rights reserved.
//

import UIKit

protocol WOWClickableDelegate {
    func onClick(view : WOWClickableView, userInfo: Any?)
}

@IBDesignable
class WOWClickableView: UIView {
    
    // MARK: - private properties
    private var _backgroundImageView : UIImageView!
    private var _labelContainer: UIView!
    private var _descriptionLabel: UILabel!
    
    // MARK: - public properties
    var delegate : WOWClickableDelegate?
    var userInfo: Any?
    
    @IBInspectable
    public var backgroudImage : UIImage? {
        didSet {
            self._backgroundImageView.image = backgroudImage
        }
    }
    
    @IBInspectable
    public var backgroundHighlightTintColor : UIColor = UIColor.clear {
        didSet {
            if let backImage = self._backgroundImageView.image {
                if let tint = backImage.colorizeImage(color: self.backgroundHighlightTintColor) {
                    self._backgroundImageView.highlightedImage = tint
                }
                //self._backgroundImageView.highlightedImage = backImage.tint(color: backgroundHighlightTintColor)
            }
        }
    }
    
    /**
     Description label padding for left and right
     */
    @IBInspectable
    public var horizontalPadding : CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /**
     Text for description in label
     */
    @IBInspectable
    public var text : String = "" {
        didSet {
            self._descriptionLabel.text = text
        }
    }
    
    @IBInspectable
    public var textColor: UIColor = UIColor.darkGray {
        didSet {
            self._descriptionLabel.textColor = textColor
        }
    }
    
    @IBInspectable
    public var textFontSize: CGFloat = 15.0 {
        didSet {
            let originalFont = self._descriptionLabel.font
            self._descriptionLabel.font = UIFont(name: (originalFont?.fontName)!, size: textFontSize)
        }
    }
    
    @IBInspectable
    public var textBackgroundColor : UIColor = UIColor.clear {
        didSet {
            self._descriptionLabel.backgroundColor = UIColor.clear
            self._labelContainer.backgroundColor = textBackgroundColor
        }
    }
    
    @IBInspectable
    public var textHeight : CGFloat = 20.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setup()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self._backgroundImageView.isHighlighted = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self._backgroundImageView.isHighlighted = false
        self.delegate?.onClick(view: self, userInfo: userInfo)
    }
    
    private func setup() {
        
        self.clipsToBounds = true
        
        // background image
        self._backgroundImageView = UIImageView(frame: self.bounds)
        self._backgroundImageView.clipsToBounds = true
        self._backgroundImageView.contentMode = .scaleAspectFill
        self._backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(_backgroundImageView)
        // TODO: padding?
        
        // label container
        let rect = CGRect(x:0,y:self.bounds.size.height-self.textHeight,width:self.bounds.size.width,height:self.textHeight)
        self._labelContainer = UIView(frame: rect )
        self._labelContainer.backgroundColor = self.textBackgroundColor
        self._labelContainer.autoresizingMask = [.flexibleWidth]
        self.addSubview(self._labelContainer)
        
         // label
        self._descriptionLabel = UILabel(frame: CGRect(x:self.horizontalPadding,y:0,width:self._labelContainer.frame.size.width-2*self.horizontalPadding, height: self._labelContainer.frame.size.height))
        self._descriptionLabel.text = self.text
        self._descriptionLabel.numberOfLines = 0
        self._descriptionLabel.textColor = self.textColor
        self.textFontSize = 10
        _labelContainer.addSubview(self._descriptionLabel)
    }
    
    override func layoutSubviews() {
        self._backgroundImageView.frame = self.bounds
        self._labelContainer.frame = CGRect(x:0,y:self.bounds.size.height-self.textHeight,width:self.bounds.size.width,height:self.textHeight)
        self._descriptionLabel.frame = CGRect(x:self.horizontalPadding,y:0,width:self._labelContainer.frame.size.width-2*self.horizontalPadding, height: self._labelContainer.frame.size.height)
    }
    
}

