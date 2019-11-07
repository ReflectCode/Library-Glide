//****************************************************************************************
//  RC_Glide.swift
//
//  Copyright (C) 2019 Reflect Code Technologies (OPC) Pvt. Ltd.
//  More details   - http://ReflectCode.com  
//
//  Description - Swift implementation of Android Glide imaging loading library.
//				  https://github.com/bumptech/glide
//
//
//  Dev Notes - This class internally uses 'AlamofireImage V3.5' to load images 
//              It provides interface which is inlined with Glide
//              Sample project - https://github.com/ReflectCode/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this 
//  software and associated documentation files (the "Software"), to deal in the Software 
//  without restriction, including without limitation the rights to use, copy, modify, merge,
//  publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
//  to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or 
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING 
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//****************************************************************************************

import Alamofire
import AlamofireImage

/// Enum to define the transition style to be used when image is loaded
public enum RC_Glide_transition {
    /// No style
    case none
    /// The PlaceHolder image is dissolved and new loaded image appears
    case withCrossFade(_ duration: Float)
    /// The PlaceHolder image is flipped with new loaded image
    case withWrapped(_ duration: Float)
}


/// This enum is just a place holder, its functionality is not yet implemented
/// https://bumptech.github.io/glide/javadocs/400/com/bumptech/glide/load/engine/DiskCacheStrategy.html
public enum RC_Glide_DiskCacheStrategy{
    case ALL
    case AUTOMATIC
    case DATA
    case NONE
    case RESOURCE
}

/// Priorities for completing loads. If more than one load is queued at a time, the load with the higher priority will be started first.
/// https://bumptech.github.io/glide/javadocs/400/com/bumptech/glide/Priority.html
/// This enum is just a place holder, its functionality is not yet implemented
public enum RC_Glide_Priority{
    case HIGH
    case IMMEDIATE
    case LOW
    case NORMAL
}


/**
 RC_Glide - Swift implementation of [Glide](https://bumptech.github.io/glide/) Android image loading and caching library
 
 The RC_Glide provides the methods with similar signature to Glide An image loading and caching library for Android.
 RC_Glide internally use ['AlamofireImage'](https://alamofire.github.io/AlamofireImage/Extensions/UIImageView.html) and 'Alamofire' Swift library for loading and caching images.
 
 - Author: [ReflectCode](http://ReflectCode.com)
 - SeeAlso: Glide for Android (https://github.com/bumptech/glide)
 - Glide Version : 4.9.0
 - AlamofireImage Version : 3.5.0
 - Alamofire Version : 3.5
 */
open class RC_Glide : NSObject, ImageFilter {
    
    public var filter: (Image) -> Image
    
    private var mInstance : AnyObject? = nil
    private var mURL : URL? = nil
    private var mView : UIImageView? = nil
    private var mImg : UIImage? = nil
    private var mColor : UIColor? = nil
    
    private var mPlaceholderImage : UIImage? = nil
    private var mErrorPlaceholderImage : UIImage? = nil
    private var mFallbackPlaceholderImage : UIImage? = nil
    
    private var mFilterToApply : String = ""
    private var mImageFilter : ImageFilter? = nil
    
    private var mTransition: RC_Glide_transition = RC_Glide_transition.none
    
    private var mDiskCacheStrategy : RC_Glide_DiskCacheStrategy? = RC_Glide_DiskCacheStrategy.AUTOMATIC
    private var mPriority : RC_Glide_Priority? = RC_Glide_Priority.NORMAL


    /**
        A closure to be executed when the image request finishes
        This is implementation of [BitmapImageViewTarget.onResourceReady](https://bumptech.github.io/glide/javadocs/400/com/bumptech/glide/request/target/BitmapImageViewTarget.html)
    */
    public typealias onResourceReadySignature = (_ bitmap: CGImage?, _ transition: NSObject?) -> Void
    private var mOnResourceReady : onResourceReadySignature? = nil

    // var onResourceReady: onResourceReadySignature? = nil
    @discardableResult
    public func onResourceReady(_ callBack: @escaping onResourceReadySignature) -> RC_Glide  {
        mOnResourceReady = callBack
        return self
    }
    
    
    /**
     Creates the RC_Glide instance that will be tied to the object. Object can be any view or view controller.
     - parameter instance: Instance of any object with which RC_Glide is associated
     - returns: returns self for chaining the RC_Glide configuration.
     
     - ToDo: When object is destroyed the associated instance of RC_Glide will also be destroyed.
     */
    @discardableResult
    public func with(_ instance: AnyObject) -> RC_Glide {
        mInstance = instance
        return RC_Glide()
    }

    
    /**
     Load the image from given URL
     - parameter URL: URL to the image
     - returns: returns self for chaining the RC_Glide configuration.
     */
    @discardableResult
    public func load(_ url: URL) -> RC_Glide  {
        mURL = url
        return self
    }

    /**
     Load the image from given UIImage
     - parameter image: UIImage containg the image to be loaded
     - returns: returns self for chaining the RC_Glide configuration.
     */
    @discardableResult
    public func load(_ image: UIImage?) -> RC_Glide  {
        if let img = image {
            mImg = img
        }
        return self
    }

    /**
     Load the image from given Color
     - parameter image: UIImage containg the image to be loaded
     - returns: returns self for chaining the RC_Glide configuration.
     */
    @discardableResult
    public func load(_ color: UIColor?) -> RC_Glide  {
        if let col = color {
            mColor = col
        }
        return self
    }
    
    /**
     Cancel any pending loads RC_Glide may have for the view and free any resources that may have been loaded from the view.
     - parameter view: View to cancel loads and free resource.
     */
    public func clear(_ view: UIImageView) -> Void {
        view.af_cancelImageRequest()
    }

    
    /**
     Sets an image to be displayed while resource is loading.
     - parameter placeholderImage: Image for place holder.
     - returns: returns self for chaining the RC_Glide configuration.
     */
    @discardableResult
    public func placeholder(_ placeholderImage: UIImage?) -> RC_Glide {
        if let img = placeholderImage {
            mPlaceholderImage = img
        }
        return self
    }
    
    
    /**
     Set of available caching strategies for media.
     - parameter strategy: Disk Cache Strategy
     - returns: returns self for chaining the RC_Glide configuration.
     - ToDo: This functionality is not supported.
     - Note: [DiskCacheStrategy](https://bumptech.github.io/glide/javadocs/400/com/bumptech/glide/load/engine/DiskCacheStrategy.html)
     */
    @discardableResult
    public func diskCacheStrategy(_ strategy: RC_Glide_DiskCacheStrategy) -> RC_Glide {
        mDiskCacheStrategy = strategy
        return self
    }
    
    
    /**
     Priorities for completing loads. If more than one load is queued at a time, the load with the higher priority will be started first.
     - parameter priority: priority enum
     - returns: returns self for chaining the RC_Glide configuration.
     
     - ToDo: This functionality is not supported.
     - Note: [Priority](https://bumptech.github.io/glide/javadocs/400/com/bumptech/glide/Priority.html)
     */
    @discardableResult
    public func priority(_ priority: RC_Glide_Priority) -> RC_Glide {
        mPriority = priority
        return self
    }
    

    /**
     Sets an image to be displayed when image download results into error.
     - parameter placeholderImage: Image for place holder in error condition.
     - returns: returns self for chaining the RC_Glide configuration.
     
     - ToDo: This functionality is not supported.
     */
    @discardableResult
    public func error(_ errorPlaceholderImage: UIImage) -> RC_Glide {
        mErrorPlaceholderImage = errorPlaceholderImage
        return self
    }
    
    
    /**
     Sets an image to be displayed when image download results into error.
     - parameter placeholderImage: Image for place holder in error condition.
     - returns: returns self for chaining the RC_Glide configuration.
     
     - ToDo: This functionality is not supported.
     */
    @discardableResult
    public func fallback(_ fallbackPlaceholderImage: UIImage) -> RC_Glide {
        mFallbackPlaceholderImage = fallbackPlaceholderImage
        return self
    }
    
    
    /** Transform the image by croping the larger side of the image.
     - returns: returns self for chaining the RC_Glide configuration.
     */
    @discardableResult
    public func centerCrop() -> RC_Glide {
        mFilterToApply = "centerCrop"
        return self
    }
    
    
    /**
     Transform the image by scalling to fit the bounds of UImageView maintaing the aspect ratio
     */
    @discardableResult
    public func fitCenter() -> RC_Glide {
        mFilterToApply = "fitCenter"
        return self
    }
    

    /**
     Transform the image by scalling to fill the bounds of UImageView maintaing the aspect ratio.
     - returns: returns self for chaining the RC_Glide configuration.
     */
    @discardableResult
    public func centerInside() -> RC_Glide {
        mFilterToApply = "centerInside"
        return self
    }

    
    /** Transform the image by croping the larger in circle shape which fits into destination UIImageView control.
     - returns: returns self for chaining the RC_Glide configuration.
     */
    @discardableResult
    public func circleCrop() -> RC_Glide {
        mFilterToApply = "circleCrop"
        return self
    }
    
    
    /**
     Provides independent options to customize the image loading.
     - parameter options: instance of 'RC_Glide_RequestOptions'
     - returns: returns self for chaining the RC_Glide configuration
     */
    @discardableResult
    public func transition(_ transitionOption: RC_Glide_transition) -> RC_Glide {
        mTransition = transitionOption
        return self
    }
    
    
    /**
     Returns the instance of RC_Glide
     - parameter instance: Instance of any object with which RC_Glide is associated
     - returns: returns self for chaining the RC_Glide configuration.
     */
    @discardableResult
    public func get(_ instance: AnyObject) -> RC_Glide {
        return self
    }
    
    
    /**
     Provides independent options to customize the image loading.
     - parameter options: instance of 'RC_Glide_RequestOptions'
     - returns: returns self for chaining the RC_Glide configuration
     */
    @discardableResult
    public func apply(_ options: RC_Glide_RequestOptions) -> RC_Glide {
        
        mFilterToApply = options.getOption()
        mPlaceholderImage = options.getPlaceholder()
        mErrorPlaceholderImage = options.getErrorPlaceholder()
        mFallbackPlaceholderImage = options.getFallbackDrawable()
        mDiskCacheStrategy = options.getDiskCacheStrategy()
        mPriority = options.getPriority()
        
        return self
    }
    
    
    /**
     This is dummy function as a placeholder which does nothing.
     - returns: returns self for chaining the RC_Glide.
     - Note: In Android Glide lib, this function attempts to always load the resource as a 'android.graphics.Bitmap', even if it could actually be animated.
     */
    @discardableResult
    public func asBitmap() -> RC_Glide  {
        return self
    }
    
    
    @discardableResult
    public func into(_ view: UIImageView, onResourceReady callBack: onResourceReadySignature?) -> UIImageView  {
        mOnResourceReady = callBack
        return into(view)
    }
    
    
    /**
     Download and set the image into image view
     - parameter view: UIImageView into which the image will be loaded.
     - returns: Returns the updated UIImageView
     */
    @discardableResult
    public func into(_ view: UIImageView) -> UIImageView {
        mView = view
        var resImg: UIImage? = nil
        
        var imgTransition: UIImageView.ImageTransition? = nil
        
        switch mTransition{
            case RC_Glide_transition.withCrossFade(let duration) :
                imgTransition = UIImageView.ImageTransition.crossDissolve(TimeInterval(duration))
            
            case RC_Glide_transition.withWrapped(let duration) :
                imgTransition = UIImageView.ImageTransition.flipFromTop(TimeInterval(duration))
            
            default :
                imgTransition = UIImageView.ImageTransition.noTransition
        }

        
        if let url = mURL {
            
            if mOnResourceReady == nil {
                mView!.af_setImage(withURL: url, placeholderImage: mPlaceholderImage, filter: self, progress: nil,  imageTransition: imgTransition!, runImageTransitionIfCached: true, completion: nil)
            } else {
                mView!.af_setImage(withURL: url, placeholderImage: mPlaceholderImage, filter: self, progress: nil,  imageTransition: imgTransition!, runImageTransitionIfCached: true, completion: {(source: DataResponse<UIImage>) -> Void in
                    let img: CGImage? = source.value?.cgImage
                    self.mOnResourceReady!(img, nil)
                })
            }
            return mView!
        }
        
        if let img = mImg {
            // Apply the Transformation
            resImg = getFilter(img)
            
            // Apply the transitions
            mView?.run(imgTransition!, with: resImg!)
            
            if let handler = mOnResourceReady {
                handler(img.cgImage, nil)
            }
            return mView!
        }
        
        if let imgColor = mColor {
            // Generate the image from color value
            let imgRec: CGRect = CGRect(x: 0, y: 0, width: mView!.frame.width, height: mView!.frame.height)
            UIGraphicsBeginImageContext(imgRec.size)
            let ctx = UIGraphicsGetCurrentContext()
            ctx!.setFillColor(imgColor.cgColor)
            ctx!.fill(imgRec)
            resImg = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // Apply the Transformation
            resImg = getFilter(resImg!)
            
            // Apply the transitions
            mView?.run(imgTransition!, with: resImg!)
            
            if let handler = mOnResourceReady {
                handler(resImg!.cgImage, nil)
            }
            
            return mView!
        }
        
        resImg = UIImage(named: "RC_help")
        
        // Handler called after loading image
        if let handler = mOnResourceReady {
            handler(resImg!.cgImage, nil)
        }
        
        return mView!
    }
    
    
    /**
     Clears the disk cache.
     */
    public func clearDiskCache() {
        UIImageView.af_sharedImageDownloader.imageCache?.removeAllImages()
    }
    
	
    /**
     Clears the disk cache.
     - ToDo: as of not this is same as clearDiskCache(). Check of there is another method to clear memory cache.
     */
    public func clearMemory() {
        UIImageView.af_sharedImageDownloader.imageCache?.removeAllImages()
    }

    
    override public init(){
        filter = RC_Glide.getFilterDummy    // ToDo : This is to clear compiler error, rectify this in future
        super.init()
        filter = getFilter
    }
    

    // ToDo : This is to clear compiler error, rectify this in future
    private static func getFilterDummy(_ img: Image) -> Image {
        return Image()
    }
    
    
    /**
        Return the ImageFilter based on the selected filter
    */
    private func getFilter(_ img: Image) -> Image {
        
        guard let dView = mView else { return img}
        
        switch mFilterToApply{
        case "centerCrop" :
            // Compute the crop
            if img.size.width > dView.frame.width || img.size.height > dView.frame.height {

                let maxWidth: CGFloat = max(img.size.width, dView.frame.width)
                let maxHeight: CGFloat = max(img.size.height, dView.frame.height)
                var xVal: CGFloat = 0.0
                var yVal: CGFloat = 0.0
                
                if img.size.width > dView.frame.width {
                    xVal = (img.size.width - dView.frame.width) / 2
                }
                
                if img.size.height > dView.frame.height {
                    yVal = (img.size.height - dView.frame.height) / 2
                }

                let cropRect: CGRect = CGRect(x: xVal, y: yVal, width: maxWidth, height: maxHeight)
                guard let cropFilter = CIFilter(name: "CICrop", parameters: ["inputImage" : img.ciImage as Any , "inputRectangle" : CIVector(cgRect: cropRect) ]) else {return img}
                return UIImage(ciImage: cropFilter.outputImage!)
                
            } else {
                return img
            }
        
        case "fitCenter" :
            return img.af_imageAspectScaled(toFit: dView.frame.size)
            
        case "centerInside" :
            return img.af_imageAspectScaled(toFill: dView.frame.size)
            
        case "circleCrop" :
            return img.af_imageRoundedIntoCircle()
            
        default:
            return img
            
        }
    }
}


public class RC_Glide_BitmapImageViewTarget{
    var mImage: UIImageView? = nil
    
    init(view: UIImageView){
        mImage = view
    }
}
