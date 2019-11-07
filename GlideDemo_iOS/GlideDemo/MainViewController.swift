// The MIT License (MIT)
//
// Copyright (c) 2019 Reflect Code Technologies (OPC) Pvt. Ltd. (http://ReflectCode.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute,
// sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit
import Alamofire
import AlamofireImage

/*
Image URLs
    1200 * 1600 : https://upload.wikimedia.org/wikipedia/commons/d/dd/Apus_apus_01.jpg
     675 *  900 : https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Apus_apus_01.jpg/675px-Apus_apus_01.jpg
     360 *  480 : https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Apus_apus_01.jpg/360px-Apus_apus_01.jpg
     109 *  145 : https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Apus_apus_01.jpg/109px-Apus_apus_01.jpg

    https://aggie-horticulture.tamu.edu/wildseed/flowers/AlamoFire.jpg
*/

public class MainViewController : UIViewController {
    
    @IBOutlet weak var imgViewOutlet: UIImageView!

    @IBAction func btnLoadFromResClick(_ v: UIView?){
        RC_Glide()
            .with(self)
            .load(UIImage(named: "contact_eight"))
            .into(imgView!)
    }


    @IBAction func btnLoadFromURLClick(_ v: UIView?){
        RC_Glide()
            .with(self)
            .load(URL(string: "https://aggie-horticulture.tamu.edu/wildseed/flowers/AlamoFire.jpg")!)
            .placeholder(UIImage(named: "rc_help"))
            .transition(RC_Glide_transition.withCrossFade(3))
            .into(imgView!)
    }


    @IBAction func btnLoadWithOptions(_ v: UIView?){
        let opt : RC_Glide_RequestOptions? = RC_Glide_RequestOptions()
            .circleCrop()
            .placeholder(UIImage(named: "rc_help")!)
            
        opt!.priority(RC_Glide_Priority.HIGH)
        opt!.diskCacheStrategy(RC_Glide_DiskCacheStrategy.AUTOMATIC)
        
        RC_Glide()
            .with(self)
            .load(URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/dd/Apus_apus_01.jpg")!)
            .apply(opt!)
            .into(imgView!)
    }


    @IBAction func btnLoadInBitmapImageViewTarget(_ v: UIView?){
        RC_Glide()
            .with(self)
            .asBitmap()
            .load(URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/dd/Apus_apus_01.jpg")!)
            .into(imgView!, onResourceReady: {(bitmap, nil) in
                print("RC : bitmap.size = (\(bitmap!.height),\(bitmap!.width))")
            })
    }


    @IBAction func btnLoadWithCircleCrop(_ v: UIView?){
        RC_Glide()
            .with(self)
            .load(UIImage(named: "contact_ten"))
            .circleCrop()
            .into(imgView!)
    }


    @IBAction func btnLoadWithCrossFade3Sec(_ v: UIView?){
        RC_Glide()
            .with(self)
            .load(UIImage(named: "contact_six"))
            .circleCrop()
            .priority(RC_Glide_Priority.HIGH)
            .diskCacheStrategy(RC_Glide_DiskCacheStrategy.AUTOMATIC)
            .transition(RC_Glide_transition.withCrossFade(3))
            .into(imgView!)
    }


    @IBAction func btnLoadCrossFade(_ v: UIView?){
        RC_Glide()
            .with(self)
            .load(UIImage(named: "contact_three"))
            .transition(RC_Glide_transition.withCrossFade(1.0))
            .into(imgView!)
    }


    @IBAction func btnLoadColor(_ v: UIView?){
        RC_Glide()
            .with(self)
            .load(UIColor(named: "colorPrimary"))
            .into(imgView!)
    }


    @IBAction func btnClearDiskCache(_ v: UIView?){
        // Clear the memory
        RC_Glide().get(self).clearMemory()
    }
    

    /*************************************************************************/
    // MARK: - Main code start
    /*************************************************************************/

    var imgView : UIImageView? = UIImageView()

    override public func viewDidLoad(){
        super.viewDidLoad()
        imgView = imgViewOutlet
    }
    
}
