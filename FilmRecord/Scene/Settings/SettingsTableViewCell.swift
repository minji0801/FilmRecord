//
//  SettingsTableViewCell.swift
//  FilmRecord
//
//  Created by 김민지 on 2022/04/14.
//  설정 화면 테이블 뷰 셀

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
    private var image = ["moon", "textformat.size.larger", "lock", "paperplane", "questionmark.circle", "info.circle"]

    /// Cell Title Text
    private var title = ["다크 모드", "글꼴", "암호 잠금", "의견 보내기", "이용 방법", "버전 정보"]

    /// Cell Detail Text
    private lazy var detail = ["", "", "", "", "", "v\(getCurrentVersion())"]

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
        imageView?.image = UIImage(systemName: image[row])
        textLabel?.text = title[row]
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
}
