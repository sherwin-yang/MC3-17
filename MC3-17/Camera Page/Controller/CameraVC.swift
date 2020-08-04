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
    
    var assetWriter: AVAssetWriter!
    var videoInput: AVAssetWriterInput!
    
    var timer: Timer!

    var hours = 0
    var minutes = 0
    var seconds = 0
    var currentDuration = "00:00:00"
    
    var URIPATH: URL!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var cameraButtonStop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
//        deleteRecentFile() //delete previous video
        goodBadStyle() //rotate label
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.startRecording()
        }
        checkCameraAccess()
        goodBadLabeling()
    }
    
    override func viewWillLayoutSubviews() {
        self.cameraPreviewLayer?.frame = self.view.bounds
    }
    
    func checkCameraAccess(){
        //cek status camera
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied{
            print("user denied camera usage")
            let alert = UIAlertController(title: "Camera access denied", message: "This app is not authorized to open camera", preferredStyle: .alert)

           alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
               DispatchQueue.main.async {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                   }
               }
           }))
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                print("user cancel the recording process")
                let value = UIInterfaceOrientation.portrait.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")

                var vc: UIViewController
                
                let mainStoryboard = UIStoryboard(name: "Drill", bundle: nil)
                vc = mainStoryboard.instantiateInitialViewController()!

                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                
                self.present(vc, animated: true, completion: nil)
           }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func startRecording(){
        if #available(iOS 11.0, *){
            let fileURL = URL(fileURLWithPath: filePath("Test"))
            assetWriter = try! AVAssetWriter(outputURL: fileURL, fileType: .mp4)
            let videoOutputSettings: Dictionary<String, Any> = [
                AVVideoCodecKey : AVVideoCodecType.h264,
                AVVideoWidthKey : UIScreen.main.bounds.size.width,
                AVVideoHeightKey : UIScreen.main.bounds.size.height
            ]
            videoInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoOutputSettings)
            videoInput.expectsMediaDataInRealTime = true
            assetWriter.add(videoInput)
            
            recorder.startCapture(handler: { (sampleBuffer, sampleType, error) in
                print(sampleBuffer)
                DispatchQueue.main.async {
                    if CMSampleBufferDataIsReady(sampleBuffer) {
                    if self.assetWriter.status == .unknown {
                        self.assetWriter.startWriting()
                        self.assetWriter.startSession(atSourceTime: CMSampleBufferGetPresentationTimeStamp(sampleBuffer))
                    }
                    
                    if self.assetWriter.status == .failed {
                        print("error")
                    }
                    if sampleType == .video {
                        if self.videoInput.isReadyForMoreMediaData {
                            self.videoInput.append(sampleBuffer)
                        }
                    }
                    self.startRunningCaptureSession()
                    }
                }
            }) { (error) in
                //cek status screen record
                if self.recorder.isRecording == false{
                    let alert = UIAlertController(title: "Failed to Record", message: "This app is not authorized to record", preferredStyle: .alert)

                   alert.addAction(UIAlertAction(title: "Allow", style: .default, handler: { (_) in
                       DispatchQueue.main.async {
                        self.startRecording()
                       }
                   }))
                   alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                        print("User cancel the recording process")
                        let value = UIInterfaceOrientation.portrait.rawValue
                        UIDevice.current.setValue(value, forKey: "orientation")

                        var vc: UIViewController
                        
                        let mainStoryboard = UIStoryboard(name: "InfoPage", bundle: nil)
                        vc = mainStoryboard.instantiateInitialViewController()!

                        vc.modalPresentationStyle = .fullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        
                        self.present(vc, animated: true, completion: nil)
//                        self.performSegue(withIdentifier: SegueIdentifier.cameraToDrillingPage, sender: nil)
                   }))
                    self.present(alert, animated: true, completion: nil)
                }
                print("error pas start capture \(error?.localizedDescription)")
            }
        }
        
        
    }
    
    // Create the capture session.
    @IBAction func cameraButtonDidTapped(_ sender: UIButton) {
//        timer.invalidate()
        print("lagi ngerecord: \(recorder.isRecording)")
        recorder.stopCapture { (error) in
            print(error?.localizedDescription)
            self.assetWriter.finishWriting {
                self.URIPATH = self.fetchURLPath().first!
                print("Fetch URLPath \(self.fetchURLPath())")
            }
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: SegueIdentifier.toVideoPage, sender: self)
            }
        }
    }
    
    func goodBadStyle(){
//        scoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        scoreLabel.layer.cornerRadius = 5
        scoreLabel.layer.masksToBounds = true
//        durationLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        durationLabel.layer.cornerRadius = 5
        durationLabel.layer.masksToBounds = true
        cameraButtonStop.layer.cornerRadius = cameraButtonStop.frame.size.height/2
    }
    
    func goodBadLabeling(){
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
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    @objc func updateLabel() {
        if seconds == 59 {
          seconds = 0
          if minutes == 59 {
            minutes = 0
            hours = hours + 1
          } else {
            minutes = minutes + 1
          }
        } else {
          seconds = seconds + 1
        }
        
        currentDuration = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        print(currentDuration)
        durationLabel.text = currentDuration
    }

    func startRunningCaptureSession(){
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true) //ga keplay dari sini
        captureSession.startRunning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == SegueIdentifier.toVideoPage {
                if let destination = segue.destination as? ResultsVideoVC {
                    destination.URIPATH = self.URIPATH
                    destination.currentDuration = self.currentDuration
                }
            }
        }
    }
}
