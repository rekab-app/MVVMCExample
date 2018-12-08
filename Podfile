platform :ios, '10.0'
inhibit_all_warnings!

##
def rx_swift
    pod 'RxSwift', '~> 4.3.1'
end

##
def rx_cocoa
    pod 'RxCocoa',    '~> 4.3.1'
end

##
def rx_gesture
    pod 'RxGesture'
end

##
def rx_datasource
    pod 'RxDataSources', '~> 3.0'
end

##
def common_pods
    rx_swift
    rx_cocoa
    rx_gesture
    rx_datasource
end

####
target 'Common' do
    use_frameworks!
    workspace 'MVVMCExample'
    project 'Common/Common.xcodeproj'
    
    common_pods
end

target 'MVVMCExample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  common_pods

  target 'MVVMCExampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MVVMCExampleUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
