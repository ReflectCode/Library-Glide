//****************************************************************************************
//  RC_Glide_RequestOptions.swift
//
//  Copyright (C) 2019 Reflect Code Technologies (OPC) Pvt. Ltd.
//  For detailed please check - http://ReflectCode.com  
//
//  Description - Swift implementation of Android Glide imaging loading library.
//				  https://github.com/bumptech/glide
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

import Foundation
import UIKit

/**
 RC_Glide - Swift implementation of Glide Android image loading and caching library
 
 The RC_Glide provides the methods with similar signature to Glide An image loading and caching library for Android.
 RC_Glide internally use 'AlamofireImage' and 'Alamofire' Swift library for loading and caching images.
 
 RC_Glide_RequestOptions is used to collectively set the image downloading options for RC_Glide
 
 - Author: ReflectCode (http://ReflectCode.com)
 - SeeAlso: Glide for Android (https://github.com/bumptech/glide)
 - Glide Version : 4.9.0
 - AlamofireImage Version : 3.5.0
 - Alamofire Version : 5.0.0 Beta-2
 
 */

public class RC_Glide_RequestOptions: NSObject{
    
    private var mFilterToApply: String = ""
    private var mPlaceholderImage : UIImage? = nil
    private var mErrorPlaceholderImage : UIImage? = nil
    private var mFallbackPlaceholderImage : UIImage? = nil
    private var mDiskCacheStrategy : RC_Glide_DiskCacheStrategy? = RC_Glide_DiskCacheStrategy.AUTOMATIC
    private var mPriority : RC_Glide_Priority? = RC_Glide_Priority.NORMAL


    public override init() {
        super.init()
    }
    
    
    /**
     Sets an image to be displayed while resource is loading
     - parameter placeholderImage: Image for place holder
     */
    @discardableResult
    public func placeholder(_ placeholderImage: UIImage) -> RC_Glide_RequestOptions {
        mPlaceholderImage = placeholderImage
        return self
    }
   
    public func getPlaceholder() -> UIImage? {
        return mPlaceholderImage
    }
    
    
    /**
     Set of available caching strategies for media.
     - parameter strategy: resource ID from R.swift to be used as a placeholder image.
     - returns: returns self for chaining the RC_Glide configuration.
     
     - ToDo: This functionality is not supported.
     - Note: [DiskCacheStrategy](https://bumptech.github.io/glide/javadocs/400/com/bumptech/glide/load/engine/DiskCacheStrategy.html)
     
     */
    @discardableResult
    public func diskCacheStrategy(_ strategy: RC_Glide_DiskCacheStrategy) -> RC_Glide_RequestOptions {
        mDiskCacheStrategy = strategy
        return self
    }
    
    public func getDiskCacheStrategy() -> RC_Glide_DiskCacheStrategy? {
        return mDiskCacheStrategy
    }
    
    
    /**
     Priorities for completing loads. If more than one load is queued at a time, the load with the higher priority will be started first.
     - parameter priority: priority enum
     - returns: returns self for chaining the RC_Glide configuration.
     
     - ToDo: This functionality is not supported.
     - Note: [Priority](https://bumptech.github.io/glide/javadocs/400/com/bumptech/glide/Priority.html)
     */
    @discardableResult
    public func priority(_ priority: RC_Glide_Priority) -> RC_Glide_RequestOptions {
        mPriority = priority
        return self
    }
    
    
    public func getPriority() -> RC_Glide_Priority? {
        return mPriority
    }
    
    
    /**
     Sets an image to be displayed when image download results into error
     - parameter placeholderImage: Image for place holder in error condition
     - ToDo: This functionality is not supported
     */
    @discardableResult
    public func error(_ errorPlaceholderImage: UIImage) -> RC_Glide_RequestOptions {
        mErrorPlaceholderImage = errorPlaceholderImage
        return self
    }
    
    public func getErrorPlaceholder() -> UIImage? {
        return mErrorPlaceholderImage
    }

    
    /**
     Sets an image to be displayed when image download results into error
     - parameter placeholderImage: Image for place holder in error condition
     - ToDo: This functionality is not supported
     */
    @discardableResult
    public func fallback(_ fallbackPlaceholderImage: UIImage) -> RC_Glide_RequestOptions {
        mFallbackPlaceholderImage = fallbackPlaceholderImage
        return self
    }
    
    public func getFallbackDrawable() -> UIImage? {
        return mFallbackPlaceholderImage
    }
    
    
    /** Transform the image by croping the larger side of the image
     */
    @discardableResult
    public func centerCrop() -> RC_Glide_RequestOptions {
        mFilterToApply = "centerCrop"
        return self
    }
    
    /**
     Transform the image by scalling to fit the bounds of UImageView maintaing the aspect ratio
     */
    @discardableResult
    public func fitCenter() -> RC_Glide_RequestOptions {
        mFilterToApply = "fitCenter"
        return self
    }
    
    /**
     Transform the image by scalling to fill the bounds of UImageView maintaing the aspect ratio
     */
    @discardableResult
    public func centerInside() -> RC_Glide_RequestOptions {
        mFilterToApply = "centerInside"
        return self
    }
    
    
    /** Transform the image by croping the larger in circle shape which fits into destination UIImageView control
		- Note: This is same as circleCrop()
     */
    @discardableResult
    public func circleCropfitCenter() -> RC_Glide_RequestOptions {
        mFilterToApply = "circleCrop"
        return self
    }
    
    /** Transform the image by croping the larger in circle shape which fits into destination UIImageView control
     */
    @discardableResult
    public func circleCrop() -> RC_Glide_RequestOptions {
        mFilterToApply = "circleCrop"
        return self
    }
	
    /** Get the transform option applied currently
     */
    public func getOption() -> String {
        return mFilterToApply
    }
    
    
}
