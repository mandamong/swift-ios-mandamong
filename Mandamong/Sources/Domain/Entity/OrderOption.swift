//
//  OrderOption.swift
//  Mandamong
//
//  Created by Swain Yun on 9/8/25.
//

import Foundation

/// 정렬기준
enum OrderOption {
    /// 이름순 정렬
    case descendingByName
    /// 생성일자순 정렬
    case descendingByCreationDate
    /// 진행도순 정렬
    case descendingByCompletion
}
