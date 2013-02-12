<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="2.0" toolsVersion="2844" systemVersion="11G63" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" initialViewController="Ayq-ua-Ry5">
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="1930"/>
    </dependencies>
    <scenes>
        <!--View Controller - Master-->
        <scene sceneID="5">
            <objects>
                <viewController storyboardIdentifier="ViewController" useStoryboardIdentifierAsRestorationIdentifier="YES" id="2" customClass="ViewController" sceneMemberID="viewController">
                    <view key="view" contentMode="scaleToFill" id="3">
                        <rect key="frame" x="0.0" y="64" width="320" height="416"/>
                        <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                        <subviews>
                            <mapView clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="scaleToFill" mapType="hybrid" showsUserLocation="YES" translatesAutoresizingMaskIntoConstraints="NO" id="Hh9-f7-CME">
                                <constraints>
                                    <constraint firstAttribute="height" constant="372" id="JXJ-n5-eko"/>
                                </constraints>
                            </mapView>
                            <tableView clipsSubviews="YES" contentMode="scaleToFill" alwaysBounceVertical="YES" dataMode="prototypes" style="plain" rowHeight="70" sectionHeaderHeight="22" sectionFooterHeight="22" translatesAutoresizingMaskIntoConstraints="NO" id="ct2-bh-kVt">
                                <color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                                <constraints>
                                    <constraint firstAttribute="height" constant="371" id="0H4-72-JVW"/>
                                </constraints>
                                <prototypes>
                                    <tableViewCell contentMode="scaleToFill" selectionStyle="blue" accessoryType="disclosureIndicator" indentationWidth="10" reuseIdentifier="Cell" rowHeight="70" id="ZTL-rt-XbR" customClass="DetailCell">
                                        <rect key="frame" x="0.0" y="22" width="320" height="70"/>
                                        <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                        <view key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center">
                                            <rect key="frame" x="0.0" y="0.0" width="300" height="69"/>
                                            <autoresizingMask key="autoresizingMask"/>
                                            <subviews>
                                                <label opaque="NO" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="left" text="myLabel" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="6kO-so-qjz">
                                                    <constraints>
                                                        <constraint firstAttribute="height" constant="31" id="DU0-Sd-pyP"/>
                                                        <constraint firstAttribute="width" constant="140" id="yZb-Ag-TdO"/>
                                                    </constraints>
                                                    <fontDescription key="fontDescription" name="Helvetica" family="Helvetica" pointSize="17"/>
                                                    <color key="textColor" cocoaTouchSystemColor="darkTextColor"/>
                                                    <color key="highlightedColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                                                </label>
                                                <imageView clipsSubviews="YES" userInteractionEnabled="NO" contentMode="scaleAspectFill" translatesAutoresizingMaskIntoConstraints="NO" id="pvD-dH-fUH">
                                                    <constraints>
                                                        <constraint firstAttribute="width" constant="120" id="Jnx-dF-V9Q"/>
                                                    </constraints>
                                                </imageView>
                                                <label opaque="NO" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="left" text="mySubLabel" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="mGP-s7-5MR">
                                                    <constraints>
                                                        <constraint firstAttribute="height" constant="24" id="GGg-OJ-vcW"/>
                                                    </constraints>
                                                    <fontDescription key="fontDescription" type="system" pointSize="13"/>
                                                    <color key="textColor" red="0.50196078430000002" green="0.50196078430000002" blue="0.50196078430000002" alpha="1" colorSpace="calibratedRGB"/>
                                                    <color key="highlightedColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                                                </label>
                                            </subviews>
                                            <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="calibratedWhite"/>
                                        </view>
                                        <constraints>
                                            <constraint firstItem="mGP-s7-5MR" firstAttribute="trailing" secondItem="6kO-so-qjz" secondAttribute="trailing" type="default" id="F8f-wP-cGS"/>
                                            <constraint firstItem="6kO-so-qjz" firstAttribute="leading" secondItem="pvD-dH-fUH" secondAttribute="trailing" constant="8" symbolic="YES" type="default" id="Zw0-ch-l1f"/>
                                            <constraint firstItem="pvD-dH-fUH" firstAttribute="bottom" secondItem="ZTL-rt-XbR" secondAttribute="bottom" type="default" id="agg-Xt-CM1"/>
                                            <constraint firstItem="mGP-s7-5MR" firstAttribute="leading" secondItem="pvD-dH-fUH" secondAttribute="trailing" constant="8" symbolic="YES" type="default" id="dda-iT-v6y"/>
                                            <constraint firstItem="pvD-dH-fUH" firstAttribute="leading" secondItem="ZTL-rt-XbR" secondAttribute="leading" type="default" id="oqc-vg-X7N"/>
                                            <constraint firstItem="pvD-dH-fUH" firstAttribute="top" secondItem="ZTL-rt-XbR" secondAttribute="top" type="default" id="skZ-Hf-t5y"/>
                                            <constraint firstAttribute="bottom" secondItem="mGP-s7-5MR" secondAttribute="bottom" constant="11" id="wud-Ap-TFp"/>
                                            <constraint firstItem="6kO-so-qjz" firstAttribute="top" secondItem="ZTL-rt-XbR" secondAttribute="top" constant="11" id="xUh-2L-fqe"/>
                                        </constraints>
                                        <connections>
                                            <outlet property="myImageView" destination="pvD-dH-fUH" id="5Mo-JK-Dou"/>
                                            <outlet property="myLabel" destination="6kO-so-qjz" id="Dkw-hx-dSo"/>
                                            <outlet property="mySubLabel" destination="mGP-s7-5MR" id="Xcb-zR-icf"/>
                                            <segue destination="HOn-5a-cX6" kind="push" identifier="detailSegue" id="lvv-bw-ggZ"/>
                                        </connections>
                                    </tableViewCell>
                                </prototypes>
                            </tableView>
                            <segmentedControl opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="top" segmentControlStyle="bar" selectedSegmentIndex="0" translatesAutoresizingMaskIntoConstraints="NO" id="r8A-cm-omw">
                                <segments>
                                    <segment title="List"/>
                                    <segment title="Map"/>
                                </segments>
                                <connections>
                                    <action selector="segmentedValueChanged:" destination="2" eventType="valueChanged" id="S0z-8y-zNa"/>
                                </connections>
                            </segmentedControl>
                        </subviews>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                        <constraints>
                            <constraint firstAttribute="trailing" secondItem="r8A-cm-omw" secondAttribute="trailing" constant="20" symbolic="YES" type="default" id="2QV-4P-jbg"/>
                            <constraint firstItem="Hh9-f7-CME" firstAttribute="trailing" secondItem="3" secondAttribute="trailing" type="default" id="FaS-a2-vDj"/>
                            <constraint firstItem="Hh9-f7-CME" firstAttribute="leading" secondItem="3" secondAttribute="leading" type="default" id="PWM-zW-uMK"/>
                            <constraint firstItem="ct2-bh-kVt" firstAttribute="trailing" secondItem="3" secondAttribute="trailing" type="default" id="TuL-Kr-4Ma"/>
                            <constraint firstItem="ct2-bh-kVt" firstAttribute="top" secondItem="r8A-cm-omw" secondAttribute="bottom" constant="8" symbolic="YES" type="default" id="ZOj-bC-1Y7"/>
                            <constraint firstItem="r8A-cm-omw" firstAttribute="leading" secondItem="3" secondAttribute="leading" constant="20" symbolic="YES" type="default" id="ak2-Qt-fUb"/>
                            <constraint firstItem="Hh9-f7-CME" firstAttribute="bottom" secondItem="3" secondAttribute="bottom" type="default" id="ehE-QF-WOU"/>
                            <constraint firstItem="ct2-bh-kVt" firstAttribute="leading" secondItem="3" secondAttribute="leading" type="default" id="iiy-Jb-3lc"/>
                            <constraint firstItem="Hh9-f7-CME" firstAttribute="top" secondItem="r8A-cm-omw" secondAttribute="bottom" constant="8" symbolic="YES" type="default" id="ukx-rM-O0v"/>
                        </constraints>
                    </view>
                    <navigationItem key="navigationItem" title="Master" id="JBf-Tw-lSV"/>
                    <simulatedStatusBarMetrics key="simulatedStatusBarMetrics" statusBarStyle="blackTranslucent"/>
                    <connections>
                        <outlet property="myMapView" destination="Hh9-f7-CME" id="lFg-Nj-fiQ"/>
                        <outlet property="myTableView" destination="ct2-bh-kVt" id="44R-kz-5Yj"/>
                        <outlet property="segmentedcontrol" destination="r8A-cm-omw" id="x5U-I9-gfC"/>
                    </connections>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="4" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="360" y="149"/>
        </scene>
        <!--Navigation Controller-->
        <scene sceneID="awT-0S-W9i">
            <objects>
                <navigationController definesPresentationContext="YES" id="Ayq-ua-Ry5" sceneMemberID="viewController">
                    <simulatedStatusBarMetrics key="simulatedStatusBarMetrics" statusBarStyle="blackTranslucent"/>
                    <navigationBar key="navigationBar" contentMode="scaleToFill" id="RhL-zu-zAu">
                        <rect key="frame" x="0.0" y="0.0" width="0.0" height="44"/>
                        <autoresizingMask key="autoresizingMask"/>
                    </navigationBar>
                    <connections>
                        <segue destination="2" kind="relationship" relationship="rootViewController" id="Lny-0m-bmj"/>
                    </connections>
                </navigationController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="qIv-sv-82X" userLabel="First Responder" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="360" y="-417"/>
        </scene>
        <!--Detail View Controller - Detail-->
        <scene sceneID="bHe-KR-s7E">
            <objects>
                <viewController storyboardIdentifier="DetaioViewController" useStoryboardIdentifierAsRestorationIdentifier="YES" id="HOn-5a-cX6" customClass="DetailViewController" sceneMemberID="viewController">
                    <view key="view" contentMode="scaleToFill" id="djD-jp-zqm">
                        <rect key="frame" x="0.0" y="64" width="320" height="700"/>
                        <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                        <subviews>
                            <mapView clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="scaleToFill" mapType="hybrid" showsUserLocation="YES" translatesAutoresizingMaskIntoConstraints="NO" id="8Z5-cI-hQe">
                                <constraints>
                                    <constraint firstAttribute="height" constant="372" id="xSZ-Yv-Ta0"/>
                                </constraints>
                            </mapView>
                            <tableView clipsSubviews="YES" contentMode="scaleToFill" alwaysBounceVertical="YES" dataMode="prototypes" style="plain" rowHeight="44" sectionHeaderHeight="22" sectionFooterHeight="22" translatesAutoresizingMaskIntoConstraints="NO" id="uGN-J4-ngh">
                                <color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                                <constraints>
                                    <constraint firstAttribute="height" constant="450" id="PFG-lx-kRd"/>
                                </constraints>
                                <view key="tableHeaderView" contentMode="scaleToFill" id="wpp-ML-T1P">
                                    <rect key="frame" x="0.0" y="0.0" width="320" height="279"/>
                                    <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                    <subviews>
                                        <imageView clipsSubviews="YES" userInteractionEnabled="NO" contentMode="scaleAspectFill" image="tsurugidake.jpg" translatesAutoresizingMaskIntoConstraints="NO" id="AcX-IS-Jqr"/>
                                        <label opaque="NO" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="left" text="Label" textAlignment="center" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="Mzu-UQ-8lr">
                                            <constraints>
                                                <constraint firstAttribute="height" constant="51" id="61c-OP-5qW"/>
                                            </constraints>
                                            <fontDescription key="fontDescription" type="system" pointSize="17"/>
                                            <color key="textColor" cocoaTouchSystemColor="darkTextColor"/>
                                            <nil key="highlightedColor"/>
                                        </label>
                                    </subviews>
                                    <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                                    <constraints>
                                        <constraint firstItem="Mzu-UQ-8lr" firstAttribute="top" secondItem="AcX-IS-Jqr" secondAttribute="bottom" constant="8" symbolic="YES" type="default" id="0pq-5O-ME1"/>
                                        <constraint firstAttribute="bottom" secondItem="Mzu-UQ-8lr" secondAttribute="bottom" constant="20" symbolic="YES" type="default" id="HEt-N1-XxV"/>
                                        <constraint firstItem="AcX-IS-Jqr" firstAttribute="trailing" secondItem="wpp-ML-T1P" secondAttribute="trailing" type="default" id="Pph-SY-sZx"/>
                                        <constraint firstItem="AcX-IS-Jqr" firstAttribute="top" secondItem="wpp-ML-T1P" secondAttribute="top" type="default" id="QI2-lH-Eoo"/>
                                        <constraint firstItem="Mzu-UQ-8lr" firstAttribute="leading" secondItem="wpp-ML-T1P" secondAttribute="leading" type="default" id="SUR-aR-dak"/>
                                        <constraint firstItem="AcX-IS-Jqr" firstAttribute="leading" secondItem="wpp-ML-T1P" secondAttribute="leading" type="default" id="XqC-e1-ZVL"/>
                                        <constraint firstItem="Mzu-UQ-8lr" firstAttribute="trailing" secondItem="wpp-ML-T1P" secondAttribute="trailing" type="default" id="vLV-X6-DUH"/>
                                    </constraints>
                                </view>
                                <view key="tableFooterView" contentMode="scaleToFill" id="TQk-nX-EHX">
                                    <rect key="frame" x="0.0" y="401" width="320" height="100"/>
                                    <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                    <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                                </view>
                                <prototypes>
                                    <tableViewCell contentMode="scaleToFill" selectionStyle="blue" accessoryType="disclosureIndicator" indentationWidth="10" reuseIdentifier="detailCell" rowHeight="50" id="V0O-FT-g6l" customClass="DetailCell">
                                        <rect key="frame" x="0.0" y="301" width="320" height="50"/>
                                        <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                        <view key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center">
                                            <rect key="frame" x="0.0" y="0.0" width="300" height="49"/>
                                            <autoresizingMask key="autoresizingMask"/>
                                            <subviews>
                                                <label opaque="NO" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="left" text="Label" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="rOs-JX-wbf">
                                                    <constraints>
                                                        <constraint firstAttribute="width" constant="200" id="ASy-9h-oFu"/>
                                                        <constraint firstAttribute="height" constant="24" id="cwU-HQ-cwJ"/>
                                                    </constraints>
                                                    <fontDescription key="fontDescription" type="system" pointSize="17"/>
                                                    <color key="textColor" cocoaTouchSystemColor="darkTextColor"/>
                                                    <color key="highlightedColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                                                </label>
                                                <imageView userInteractionEnabled="NO" contentMode="scaleAspectFit" translatesAutoresizingMaskIntoConstraints="NO" id="zYx-gg-e9e">
                                                    <constraints>
                                                        <constraint firstAttribute="width" constant="40" id="W0k-lh-bP7"/>
                                                        <constraint firstAttribute="height" constant="40" id="Xwf-Ut-DSO"/>
                                                    </constraints>
                                                </imageView>
                                            </subviews>
                                            <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="calibratedWhite"/>
                                        </view>
                                        <constraints>
                                            <constraint firstItem="rOs-JX-wbf" firstAttribute="leading" secondItem="zYx-gg-e9e" secondAttribute="trailing" constant="8" symbolic="YES" type="default" id="6e5-Pv-bVK"/>
                                            <constraint firstItem="rOs-JX-wbf" firstAttribute="centerX" secondItem="V0O-FT-g6l" secondAttribute="centerX" type="default" id="HpG-Mc-MHX"/>
                                            <constraint firstItem="rOs-JX-wbf" firstAttribute="centerY" secondItem="zYx-gg-e9e" secondAttribute="centerY" type="default" id="hMR-iu-mID"/>
                                            <constraint firstItem="rOs-JX-wbf" firstAttribute="centerY" secondItem="V0O-FT-g6l" secondAttribute="centerY" type="default" id="nrk-Ng-ezw"/>
                                        </constraints>
                                        <connections>
                                            <outlet property="detailCellImageView" destination="zYx-gg-e9e" id="XLH-Qq-mca"/>
                                            <outlet property="detailCellLabel" destination="rOs-JX-wbf" id="NOK-vH-6Ju"/>
                                            <segue destination="myn-3O-jCe" kind="push" identifier="infoSegue" id="ehI-6Z-RNB"/>
                                        </connections>
                                    </tableViewCell>
                                    <tableViewCell contentMode="scaleToFill" selectionStyle="blue" accessoryType="disclosureIndicator" indentationWidth="10" reuseIdentifier="detailCell2" rowHeight="50" id="0br-hq-ukG" customClass="DetailCell">
                                        <rect key="frame" x="0.0" y="351" width="320" height="50"/>
                                        <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                        <view key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center">
                                            <rect key="frame" x="0.0" y="0.0" width="300" height="49"/>
                                            <autoresizingMask key="autoresizingMask"/>
                                            <subviews>
                                                <imageView userInteractionEnabled="NO" contentMode="scaleAspectFit" translatesAutoresizingMaskIntoConstraints="NO" id="U67-cG-Aia">
                                                    <constraints>
                                                        <constraint firstAttribute="width" constant="40" id="HOJ-T0-ZvJ"/>
                                                        <constraint firstAttribute="height" constant="40" id="hvx-v3-g2A"/>
                                                    </constraints>
                                                </imageView>
                                                <label opaque="NO" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="left" text="Label" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="4bj-rN-D0y">
                                                    <constraints>
                                                        <constraint firstAttribute="width" constant="200" id="9Pv-C5-l1c"/>
                                                        <constraint firstAttribute="height" constant="24" id="AM0-xe-lJC"/>
                                                    </constraints>
                                                    <fontDescription key="fontDescription" type="system" pointSize="17"/>
                                                    <color key="textColor" cocoaTouchSystemColor="darkTextColor"/>
                                                    <color key="highlightedColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                                                </label>
                                            </subviews>
                                            <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="calibratedWhite"/>
                                        </view>
                                        <constraints>
                                            <constraint firstItem="4bj-rN-D0y" firstAttribute="centerY" secondItem="U67-cG-Aia" secondAttribute="centerY" type="default" id="Odm-B2-8aX"/>
                                            <constraint firstItem="4bj-rN-D0y" firstAttribute="centerX" secondItem="0br-hq-ukG" secondAttribute="centerX" type="default" id="Qms-Zu-WW0"/>
                                            <constraint firstItem="4bj-rN-D0y" firstAttribute="leading" secondItem="U67-cG-Aia" secondAttribute="trailing" constant="8" symbolic="YES" type="default" id="hXy-lC-Yze"/>
                                            <constraint firstItem="4bj-rN-D0y" firstAttribute="centerY" secondItem="0br-hq-ukG" secondAttribute="centerY" type="default" id="tZI-Sz-Pkz"/>
                                        </constraints>
                                        <connections>
                                            <outlet property="detailCellImageView" destination="U67-cG-Aia" id="1Ko-QJ-0Zn"/>
                                            <outlet property="detailCellLabel" destination="4bj-rN-D0y" id="q9K-Zh-AhK"/>
                                            <segue destination="V08-0I-P0T" kind="push" identifier="directinfodetailSegue" id="IhT-cB-Pbh"/>
                                        </connections>
                                    </tableViewCell>
                                </prototypes>
                            </tableView>
                            <segmentedControl opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="left" contentVerticalAlignment="top" segmentControlStyle="bar" selectedSegmentIndex="0" translatesAutoresizingMaskIntoConstraints="NO" id="YLi-Pj-4PA">
                                <segments>
                                    <segment title="Guide"/>
                                    <segment title="Map"/>
                                </segments>
                                <connections>
                                    <action selector="segmentedValueChanged:" destination="HOn-5a-cX6" eventType="valueChanged" id="Tew-i4-yJH"/>
                                </connections>
                            </segmentedControl>
                        </subviews>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                        <constraints>
                            <constraint firstItem="8Z5-cI-hQe" firstAttribute="trailing" secondItem="djD-jp-zqm" secondAttribute="trailing" type="default" id="7Ae-9B-MMq"/>
                            <constraint firstAttribute="trailing" secondItem="YLi-Pj-4PA" secondAttribute="trailing" constant="20" symbolic="YES" type="default" id="I7Q-wE-byF"/>
                            <constraint firstItem="8Z5-cI-hQe" firstAttribute="leading" secondItem="djD-jp-zqm" secondAttribute="leading" type="default" id="Ikb-iP-W7b"/>
                            <constraint firstItem="uGN-J4-ngh" firstAttribute="leading" secondItem="djD-jp-zqm" secondAttribute="leading" type="default" id="SIm-xp-n0g"/>
                            <constraint firstItem="YLi-Pj-4PA" firstAttribute="leading" secondItem="djD-jp-zqm" secondAttribute="leading" constant="20" symbolic="YES" type="default" id="SV2-6X-Jro"/>
                            <constraint firstItem="uGN-J4-ngh" firstAttribute="top" secondItem="YLi-Pj-4PA" secondAttribute="bottom" constant="8" symbolic="YES" type="default" id="Snh-CS-dhw"/>
                            <constraint firstItem="8Z5-cI-hQe" firstAttribute="top" secondItem="YLi-Pj-4PA" secondAttribute="bottom" constant="8" symbolic="YES" type="default" id="bN3-42-bcX"/>
                            <constraint firstItem="YLi-Pj-4PA" firstAttribute="top" secondItem="djD-jp-zqm" secondAttribute="top" constant="7" id="eeN-Lq-Kj7"/>
                            <constraint firstItem="uGN-J4-ngh" firstAttribute="trailing" secondItem="djD-jp-zqm" secondAttribute="trailing" type="default" id="xx9-bl-fi7"/>
                        </constraints>
                    </view>
                    <navigationItem key="navigationItem" title="Detail" id="6Qf-Zp-rQQ"/>
                    <simulatedStatusBarMetrics key="simulatedStatusBarMetrics" statusBarStyle="blackTranslucent"/>
                    <freeformSimulatedSizeMetrics key="simulatedDestinationMetrics"/>
                    <connections>
                        <outlet property="detailDescriptionLabel" destination="Mzu-UQ-8lr" id="x3J-8U-Dix"/>
                        <outlet property="detailMapView" destination="8Z5-cI-hQe" id="ydu-Nu-Dul"/>
                        <outlet property="detailTableView" destination="uGN-J4-ngh" id="Ruv-PQ-l6i"/>
                        <outlet property="detailsegmentedcontrol" destination="YLi-Pj-4PA" id="JZD-sz-VZ7"/>
                    </connections>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="cte-Qz-wW7" userLabel="First Responder" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="786" y="-281"/>
        </scene>
        <!--Info View Controller - Information-->
        <scene sceneID="eFF-Dt-a7J">
            <objects>
                <viewController storyboardIdentifier="InfoViewController" useStoryboardIdentifierAsRestorationIdentifier="YES" id="myn-3O-jCe" customClass="InfoViewController" sceneMemberID="viewController">
                    <view key="view" contentMode="scaleToFill" id="PHN-vw-S9g">
                        <rect key="frame" x="0.0" y="64" width="320" height="416"/>
                        <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                        <subviews>
                            <tableView clipsSubviews="YES" contentMode="scaleToFill" alwaysBounceVertical="YES" dataMode="prototypes" style="plain" rowHeight="44" sectionHeaderHeight="22" sectionFooterHeight="22" translatesAutoresizingMaskIntoConstraints="NO" id="tuO-WX-H3t">
                                <color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                                <label key="tableFooterView" opaque="NO" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="left" text="Label" textAlignment="center" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" id="zzG-qg-Ovs">
                                    <rect key="frame" x="0.0" y="72" width="320" height="44"/>
                                    <fontDescription key="fontDescription" type="system" pointSize="17"/>
                                    <color key="textColor" cocoaTouchSystemColor="darkTextColor"/>
                                    <nil key="highlightedColor"/>
                                </label>
                                <prototypes>
                                    <tableViewCell contentMode="scaleToFill" selectionStyle="blue" accessoryType="disclosureIndicator" indentationWidth="10" reuseIdentifier="infoCell" rowHeight="50" id="8XC-F6-JHu" customClass="DetailCell">
                                        <rect key="frame" x="0.0" y="22" width="320" height="50"/>
                                        <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                                        <view key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center">
                                            <rect key="frame" x="0.0" y="0.0" width="300" height="49"/>
                                            <autoresizingMask key="autoresizingMask"/>
                                            <subviews>
                                                <label opaque="NO" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="left" text="Label" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="OT8-8g-elR">
                                                    <constraints>
                                                        <constraint firstAttribute="height" constant="24" id="2qu-5H-COC"/>
                                                        <constraint firstAttribute="width" constant="200" id="Hpz-ru-F3m"/>
                                                    </constraints>
                                                    <fontDescription key="fontDescription" type="system" pointSize="17"/>
                                                    <color key="textColor" cocoaTouchSystemColor="darkTextColor"/>
                                                    <color key="highlightedColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                                                </label>
                                                <imageView userInteractionEnabled="NO" contentMode="scaleAspectFit" translatesAutoresizingMaskIntoConstraints="NO" id="9KA-mK-0C3">
                                                    <constraints>
                                                        <constraint firstAttribute="width" constant="40" id="65a-OG-RP9"/>
                                                        <constraint firstAttribute="height" constant="40" id="Zjk-RO-gBW"/>
                                                    </constraints>
                                                </imageView>
                                            </subviews>
                                            <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="calibratedWhite"/>
                                        </view>
                                        <constraints>
                                            <constraint firstItem="OT8-8g-elR" firstAttribute="centerX" secondItem="8XC-F6-JHu" secondAttribute="centerX" type="default" id="VRO-k3-1Za"/>
                                            <constraint firstItem="OT8-8g-elR" firstAttribute="leading" secondItem="9KA-mK-0C3" secondAttribute="trailing" constant="8" symbolic="YES" type="default" id="p5T-Tc-i5t"/>
                                            <constraint firstItem="OT8-8g-elR" firstAttribute="centerY" secondItem="8XC-F6-JHu" secondAttribute="centerY" type="default" id="tZ8-tF-vAb"/>
                                            <constraint firstItem="9KA-mK-0C3" firstAttribute="centerY" secondItem="OT8-8g-elR" secondAttribute="centerY" type="default" id="tof-35-STC"/>
                                        </constraints>
                                        <connections>
                                            <outlet property="infoCellImageView" destination="9KA-mK-0C3" id="FX6-I2-EHC"/>
                                            <outlet property="infoCellLabel" destination="OT8-8g-elR" id="P5X-z8-14h"/>
                                            <segue destination="V08-0I-P0T" kind="push" identifier="infodetailSegue" id="TOJ-Lc-gbZ"/>
                                        </connections>
                                    </tableViewCell>
                                </prototypes>
                            </tableView>
                        </subviews>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                        <constraints>
                            <constraint firstItem="tuO-WX-H3t" firstAttribute="bottom" secondItem="PHN-vw-S9g" secondAttribute="bottom" type="default" id="2lF-n8-mVK"/>
                            <constraint firstItem="tuO-WX-H3t" firstAttribute="leading" secondItem="PHN-vw-S9g" secondAttribute="leading" type="default" id="bHp-49-46i"/>
                            <constraint firstItem="tuO-WX-H3t" firstAttribute="trailing" secondItem="PHN-vw-S9g" secondAttribute="trailing" type="default" id="m9G-6J-yZJ"/>
                            <constraint firstItem="tuO-WX-H3t" firstAttribute="top" secondItem="PHN-vw-S9g" secondAttribute="top" type="default" id="vv9-vB-o6h"/>
                        </constraints>
                    </view>
                    <navigationItem key="navigationItem" title="Information" id="WTr-Ku-u14"/>
                    <simulatedStatusBarMetrics key="simulatedStatusBarMetrics" statusBarStyle="blackTranslucent"/>
                    <freeformSimulatedSizeMetrics key="simulatedDestinationMetrics"/>
                    <connections>
                        <outlet property="infoLabel" destination="zzG-qg-Ovs" id="las-7m-plL"/>
                        <outlet property="infoTableView" destination="tuO-WX-H3t" id="zDg-xl-cNZ"/>
                    </connections>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="Xko-Qt-nyU" userLabel="First Responder" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="1363" y="149"/>
        </scene>
        <!--Info Detail View Controller - InfoDetail-->
        <scene sceneID="cA6-9x-kGt">
            <objects>
                <viewController storyboardIdentifier="InfoDetailViewController" useStoryboardIdentifierAsRestorationIdentifier="YES" id="V08-0I-P0T" customClass="InfoDetailViewController" sceneMemberID="viewController">
                    <view key="view" contentMode="scaleToFill" id="JMA-GB-AIy">
                        <rect key="frame" x="0.0" y="64" width="320" height="416"/>
                        <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                        <subviews>
                            <label opaque="NO" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="left" text="Label" textAlignment="center" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="vKE-Up-m3r">
                                <constraints>
                                    <constraint firstAttribute="height" constant="40" id="6H7-Hf-Lho"/>
                                    <constraint firstAttribute="width" constant="200" id="pY4-bE-jLy"/>
                                </constraints>
                                <fontDescription key="fontDescription" type="system" pointSize="17"/>
                                <color key="textColor" cocoaTouchSystemColor="darkTextColor"/>
                                <nil key="highlightedColor"/>
                            </label>
                            <textView clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="scaleToFill" text="Text" translatesAutoresizingMaskIntoConstraints="NO" id="ydg-tC-jnE">
                                <color key="backgroundColor" red="1" green="1" blue="1" alpha="1" colorSpace="calibratedRGB"/>
                                <fontDescription key="fontDescription" type="system" pointSize="14"/>
                                <textInputTraits key="textInputTraits" autocapitalizationType="sentences"/>
                            </textView>
                        </subviews>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                        <constraints>
                            <constraint firstItem="ydg-tC-jnE" firstAttribute="bottom" secondItem="JMA-GB-AIy" secondAttribute="bottom" type="default" id="GxM-V0-zFm"/>
                            <constraint firstItem="ydg-tC-jnE" firstAttribute="top" secondItem="vKE-Up-m3r" secondAttribute="bottom" constant="8" symbolic="YES" type="default" id="LaC-pS-1xL"/>
                            <constraint firstItem="ydg-tC-jnE" firstAttribute="trailing" secondItem="JMA-GB-AIy" secondAttribute="trailing" type="default" id="OeY-O7-fNe"/>
                            <constraint firstItem="ydg-tC-jnE" firstAttribute="leading" secondItem="JMA-GB-AIy" secondAttribute="leading" type="default" id="r0j-jp-b7G"/>
                            <constraint firstItem="vKE-Up-m3r" firstAttribute="top" secondItem="JMA-GB-AIy" secondAttribute="top" constant="5" id="vq7-3n-pGG"/>
                            <constraint firstItem="ydg-tC-jnE" firstAttribute="centerX" secondItem="vKE-Up-m3r" secondAttribute="centerX" type="default" id="x8c-r5-PE7"/>
                        </constraints>
                    </view>
                    <navigationItem key="navigationItem" title="InfoDetail" id="WYL-ds-IC8"/>
                    <simulatedStatusBarMetrics key="simulatedStatusBarMetrics" statusBarStyle="blackTranslucent"/>
                    <freeformSimulatedSizeMetrics key="simulatedDestinationMetrics"/>
                    <connections>
                        <outlet property="infodetailLabel" destination="vKE-Up-m3r" id="nzp-tH-aXN"/>
                        <outlet property="myTextView" destination="ydg-tC-jnE" id="ObF-EO-MLT"/>
                    </connections>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="G2l-5T-B0b" userLabel="First Responder" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="1363" y="-417"/>
        </scene>
    </scenes>
    <resources>
        <image name="tsurugidake.jpg" width="1024" height="684"/>
    </resources>
    <simulatedMetricsContainer key="defaultSimulatedMetrics">
        <simulatedStatusBarMetrics key="statusBar"/>
        <simulatedOrientationMetrics key="orientation"/>
        <simulatedScreenMetrics key="destination"/>
    </simulatedMetricsContainer>
    <inferredMetricsTieBreakers>
        <segue reference="TOJ-Lc-gbZ"/>
    </inferredMetricsTieBreakers>
</document>