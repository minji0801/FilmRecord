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
    private let image = [
        ["paintbrush", "textformat.size.larger"],
        ["lock", "faceid"],    // TODO: Touch ID 사용 기기에는 touchid (둘 다 사용안하면 다른 이미지)
        ["paperplane", "questionmark.circle", "info.circle"],
//        ["star", "paperplane", "questionmark.circle", "info.circle"],
        ["scoit", "hours", "modakyi"]
    ]

    /// Cell ImageView TintColor
    private let imageTintColor = [
        UIColor.systemOrange,
        UIColor.systemGreen,
        UIColor.systemBlue,
        UIColor.label
    ]

    /// Cell Title Text
    private let title = [
        ["테마", "글꼴"],
        ["암호 잠금", "Touch ID / Face ID"],
        ["의견 보내기", "이용 방법", "버전 정보"],
//        ["별점 남기기", "의견 보내기", "이용 방법", "버전 정보"],
        ["Scoit", "h:ours", "모닥이"]
    ]

    /// Cell Detail Text
    private let detail = [
        ["", ""],
        ["", ""],
        ["", "", "v1.0.0"],
//        ["", "", "", "v1.0.0"],
        ["스쿼트 챌린지 앱", "시간 및 디데이 계산 앱", "명언 및 글귀 모음 앱"]
    ]

    /// 셀 UI 업데이트
    func update(indexPath: IndexPath) {
        setupView(indexPath.section, indexPath.row)
        selectionStyle = .none
    }
}

private extension SettingsTableViewCell {
    /// 셀 뷰 구성
    func setupView(_ section: Int, _ row: Int) {

        if section == 3 {
            imageView?.image = UIImage(named: image[section][row])
        } else {
            imageView?.image = UIImage(systemName: image[section][row])
        }
        imageView?.tintColor = imageTintColor[section]

        textLabel?.text = title[section][row]
        textLabel?.font = .systemFont(ofSize: 17.0, weight: .regular)

        detailTextLabel?.text = detail[section][row]
        detailTextLabel?.font = .systemFont(ofSize: 14.0, weight: .regular)
    }
}
