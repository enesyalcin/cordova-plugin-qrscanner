import Foundation
import Capacitor
import AVFoundation

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(QRScanner)
public class QRScanner: CAPPlugin, AVCaptureMetadataOutputObjectsDelegate {
    
    // The Managed App configuration dictionary pushed down from an MDM server are stored in this key.
    static var kConfigurationKey = "com.apple.configuration.managed";
    
    @objc func getConfig(_ call: CAPPluginCall) {
        if let managedConfigDict = UserDefaults.standard.dictionary(forKey: QRScanner.kConfigurationKey) {
            if let keyValue = managedConfigDict["keyName"] {
                print("KEY: keyname \nVALUE : \(keyValue) ")
            } else {
                print("Error fetching app config values.")
            }
        }
    }
    
    class CameraView: UIView {
        var videoPreviewLayer:AVCaptureVideoPreviewLayer?
        
        func interfaceOrientationToVideoOrientation(_ orientation : UIInterfaceOrientation) -> AVCaptureVideoOrientation {
            switch (orientation) {
            case UIInterfaceOrientation.portrait:
                return AVCaptureVideoOrientation.portrait;
            case UIInterfaceOrientation.portraitUpsideDown:
                return AVCaptureVideoOrientation.portraitUpsideDown;
            case UIInterfaceOrientation.landscapeLeft:
                return AVCaptureVideoOrientation.landscapeLeft;
            case UIInterfaceOrientation.landscapeRight:
                return AVCaptureVideoOrientation.landscapeRight;
            default:
                return AVCaptureVideoOrientation.portraitUpsideDown;
            }
        }

        override func layoutSubviews() {
            super.layoutSubviews();
            if let sublayers = self.layer.sublayers {
                for layer in sublayers {
                    layer.frame = self.bounds;
                }
            }
            
            self.videoPreviewLayer?.connection?.videoOrientation = interfaceOrientationToVideoOrientation(UIApplication.shared.statusBarOrientation);
        }
        
        
        func addPreviewLayer(_ previewLayer:AVCaptureVideoPreviewLayer?) {
            previewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewLayer!.frame = self.bounds
            self.layer.addSublayer(previewLayer!)
            self.videoPreviewLayer = previewLayer;
        }
        
        func removePreviewLayer() {
            if self.videoPreviewLayer != nil {
                self.videoPreviewLayer!.removeFromSuperlayer()
                self.videoPreviewLayer = nil
            }
        }
    }


    @objc func echo(_ call: CAPPluginCall) {
        var cameraView: CameraView!
//        generate on mainthread the view
        DispatchQueue.main.async {
            cameraView = CameraView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            cameraView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        }


        let value = call.getString("value") ?? ""
        call.success([
            "value": value
        ])
    }

}
