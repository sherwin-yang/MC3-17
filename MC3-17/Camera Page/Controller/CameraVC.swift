//
//  CameraVC.swift
//  MC3-17
//
//  Created by Basit Tri Anggoro on 25/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit
import AVKit
import ReplayKit
import Photos

class CameraVC: UIViewController, RPPreviewViewControllerDelegate{
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    let recorder = RPScreenRecorder.shared()
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var cameraButtonStop: UIButton!
    
        
//    var buttonWindow: UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goodBadLabeling() //rotate label
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRecording()
        startRunningCaptureSession()
    }
    
    // Create the capture session.
    @IBAction func cameraButtonDidTapped(_ sender: UIButton) {
        recorder.stopRecording { (previewVC, error) in
            if let previewVC = previewVC{
                previewVC.modalPresentationStyle = .overFullScreen
                previewVC.previewControllerDelegate = self
                self.present(previewVC, animated: true, completion: nil)
                self.performSegue(withIdentifier: "showVideoSegue", sender: nil)
            }
            if let error = error{
                print(error)
            }
        }
    }
    
    func startRecording(){
        //memulai perekaman
        recorder.startRecording { (error) in
            if let error = error{
                print(error)
            }
        }
    }
    
    func goodBadLabeling(){
        scoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        scoreLabel.layer.cornerRadius = 5
        scoreLabel.layer.masksToBounds = true
        durationLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        durationLabel.layer.cornerRadius = 5
        durationLabel.layer.masksToBounds = true
        cameraButtonStop.layer.cornerRadius = cameraButtonStop.frame.size.height/2
    }

    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        self.performSegue(withIdentifier: "showVideoSegue", sender: nil)
    }
    
    // Find the default audio device.
    func setupCaptureSession(){
        //specifies image quality
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }

    func setupDevice(){
        //captureSession.beginConfiguration()
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes:
        [.builtInTrueDepthCamera, .builtInDualCamera, .builtInWideAngleCamera],
        mediaType: .video, position: .unspecified)

        let devices = discoverySession.devices

        for device in devices{
            if device.position == AVCaptureDevice.Position.back{
                backCamera = device
            }else if device.position == AVCaptureDevice.Position.front{
                frontCamera = device
            }
        }
        currentCamera = backCamera
    }

    func setupInputOutput(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }

    func setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }

    func startRunningCaptureSession(){
        captureSession.startRunning()
    }
}
