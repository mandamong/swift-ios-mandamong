//
//  Mandamong.swift
//  DesignSystem
//
//  Created by SwainYun on 10/6/25.
//

import Foundation

/// 앱  최상위 네임스페이스
public enum Mandamong { }

// MARK: - Mandamong + Strings
extension Mandamong {
    /// 문자열 리터럴
    public enum Strings {
        public enum Common {
            public static let grid: String = "격자형"
            public static let list: String = "목록형"
            public static let delete: String = "삭제"
        }
        
        /// 로그인 화면 관련 리터럴
        public enum Login {
            public static let title: String = "로그인"
            public static let subtitle: String = "계정에 로그인하고 만다르트를 만들어보세요."
            public static let emailPlaceholder: String = "이메일"
            public static let passwordPlaceholder: String = "비밀번호"
            public static let loginButtonTitle: String = "로그인"
            public static let switchToRegisterButtonTitle: String = "회원가입"
            public static let switchToAdjustPasswordButtonTitle: String = "비밀번호 찾기"
        }
        
        /// 회원가입 화면 관련 리터럴
        public enum Register {
            public static let title: String = "회원가입"
            public static let subtitle: String = "계정을 생성하고 만다르트를 만들어보세요."
            public static let emailPlaceholder: String = "이메일"
            public static let nicknamePlaceholder: String = "닉네임"
            public static let passwordPlaceholder: String = "비밀번호"
            public static let passwordConfirmationPlaceholder: String = "비밀번호 재입력"
            public static let registerButtonTitle: String = "회원가입"
            public static let switchToLoginButtonTitle: String = "이미 계정이 있으신가요? 로그인"
        }
        
        /// 만다라트 관련 리터럴
        public enum Mandarat {
            public static let mandarat: String = "만다라트"
            public static let subject: String = "핵심 주제"
            public static let objective: String = "세부 목표"
            public static let actionIdea: String = "행동 아이디어"
        }
    }
}

// MARK: - Mandamong - Constants
extension Mandamong {
    /// 상수값
    public enum Constants {
//        public static let defaultCornerRadius: CGFloat = 8
    }
}
