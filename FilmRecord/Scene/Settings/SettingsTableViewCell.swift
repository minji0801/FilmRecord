//
//  SettingsTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/14.
//  설정 화면 테이블 뷰 셀

import LocalAuthentication
import UIKit

final class SettingsTableViewCell: UITableViewCell {
    static let identifier = "SettingsTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: SettingsTableViewCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Cell Icon Image
    private var image = ["moon", "textformat.size.larger", "lock", "faceid", "paperplane", "questionmark.circle", "info.circle"]

    /// Cell Title Text
    private var title = ["다크 모드", "글꼴", "암호 잠금", "Touch ID / Face ID", "의견 보내기", "이용 방법", "버전 정보"]

    /// Cell Detail Text
    private lazy var detail = ["", "", "", "", "", "", "v\(getCurrentVersion())"]

    /// 셀 UI 업데이트
    func update(indexPath: IndexPath) {

        setupView(indexPath.row)
        applyFont()

        selectionStyle = .none
    }
}

private extension SettingsTableViewCell {
    /// 셀 뷰 구성
    func setupView(_ row: Int) {
        // Touch ID / Face ID
        if row == 3 {
            // 생체 인증 사용할 수 있는지
            isUserInteractionEnabled = canEvaluatePolicy()
            textLabel?.isEnabled = canEvaluatePolicy()
            imageView?.tintColor = canEvaluatePolicy() ? .label : .secondaryLabel

            // 생체 인증 종류에 따라 이미지 적용
            switch getBiometryType() {
            case .touchID:
                image[3] = "touchid"
                title[3] = "Touch ID"
            case .faceID:
                image[3] = "faceid"
                title[3] = "Face ID"
            default:
                break
            }
        }

        imageView?.image = UIImage(systemName: image[row])
        textLabel?.text = title[row]
//        detail[6] = "v\(getCurrentVersion())"    // 현재 버전 가져오기
        detailTextLabel?.text = detail[row]
    }

    /// 폰트 적용
    func applyFont() {
        let font = FontManager.getFont()

        textLabel?.font = font.largeFont
        detailTextLabel?.font = font.largeFont
    }

    /// 현재 버전 가져오기
    func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }

    /// Touch ID/ Face ID 사용할 수 있는지
    func canEvaluatePolicy() -> Bool {
        let context = LAContext()
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }

    /// 생체인증 타입 가져오기
    func getBiometryType() -> LABiometryType {
        let context = LAContext()
        switch context.biometryType {
        case .faceID:
            return .faceID
        case .touchID:
            return .touchID
        default:
            return .none
        }
    }
}
