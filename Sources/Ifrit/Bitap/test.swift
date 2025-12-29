//import Foundation
//
//// MARK: - Тестові дані
//let corpus: [(pattern: String, text: String)] = [
//    ("alex", "hey im alex, how are you?"),
//    ("aba", "abababababa"),
//    ("alex", "aelx"),
//    ("abcde", "bcde abde abccde abzde abdce"),
//    ("abac", "acb")
//]
//
//// MARK: - Перевірка find
//func testFind() {
//    for (i, caseData) in corpus.enumerated() {
//        let base = referenceFind(pattern: caseData.pattern, text: caseData.text)
//        let actual = try! BitapPattern(caseData.pattern).find(in: caseData.text)
//        assert(base == actual, "case \(i) failed find(\"\(caseData.pattern)\", \"\(caseData.text)\")")
//    }
//}
//
//// MARK: - Перевірка Levenshtein
//func testLevenshtein() {
//    for (i, caseData) in corpus.enumerated() {
//        let maxK = caseData.pattern.count + 2
//        for k in 0...maxK {
//            let base = referenceLevenshtein(pattern: caseData.pattern, text: caseData.text, k: k)
//            let actual = try! BitapPattern(caseData.pattern).lev(in: caseData.text, maxDistance: k)
//            assert(base == actual, "case \(i) failed lev(\"\(caseData.pattern)\", \"\(caseData.text)\", \(k))")
//        }
//    }
//}
//
//// MARK: - Перевірка Optimal String Alignment
//func testOSA() {
//    for (i, caseData) in corpus.enumerated() {
//        let maxK = caseData.pattern.count + 2
//        for k in 0...maxK {
//            let base = referenceOSA(pattern: caseData.pattern, text: caseData.text, k: k)
//            let actual = try! BitapPattern(caseData.pattern).osa(in: caseData.text, maxDistance: k)
//            assert(base == actual, "case \(i) failed osa(\"\(caseData.pattern)\", \"\(caseData.text)\", \(k))")
//        }
//    }
//}
//
//// MARK: - Property‑style перевірки (просте)
//func qcFind(pattern: String, text: String) {
//    guard pattern.count > 0 else { return }
//    let a = try! BitapPattern(pattern).find(in: text)
//    let b = referenceFind(pattern: pattern, text: text)
//    assert(a == b, "qc_find failed for pattern: \(pattern), text: \(text)")
//}
//
//func qcLev(pattern: String, text: String, k: Int) {
//    guard pattern.count > 0 else { return }
//    let a = try! BitapPattern(pattern).lev(in: text, maxDistance: k)
//    let b = referenceLevenshtein(pattern: pattern, text: text, k: k)
//    assert(a == b, "qc_lev failed for pattern: \(pattern), text: \(text), k: \(k)")
//}
//
//func qcOsa(pattern: String, text: String, k: Int) {
//    guard pattern.count > 0 else { return }
//    let a = try! BitapPattern(pattern).osa(in: text, maxDistance: k)
//    let b = referenceOSA(pattern: pattern, text: text, k: k)
//    assert(a == b, "qc_osa failed for pattern: \(pattern), text: \(text), k: \(k)")
//}
