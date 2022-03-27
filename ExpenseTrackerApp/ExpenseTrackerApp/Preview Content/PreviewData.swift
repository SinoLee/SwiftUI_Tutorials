//
//  PreviewData.swift
//  ExpenseTrackerApp
//
//  Created by Taeyoun Lee on 2022/03/26.
//

import SwiftUI

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
