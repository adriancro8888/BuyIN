


import UIKit

enum PaginationState {
    case ready
    case waiting
}

enum PaginationDirection {
    case verical
    case horizontal
}

protocol Paginating: AnyObject {
    
    var paginationThreshold: CGFloat             { get }
    var paginationState:     PaginationState     { get set }
    var paginationDirection: PaginationDirection { get }
    
    var contentSize:   CGSize       { get }
    var bounds:        CGRect       { get }
    var contentOffset: CGPoint      { get }
    var contentInset:  UIEdgeInsets { get }
    
    func shouldBeginPaging() -> Bool
    func willBeginPaging()
    func didCompletePaging()
}

// ----------------------------------
//  MARK: - Default Implementation -
//
extension Paginating {
    
    // ----------------------------------
    //  MARK: - Content Management -
    //
    var contentOffsetDelta: CGSize {
        var delta     = self.contentSize - (self.bounds.size + self.contentOffset)
        
        delta.width  += self.contentInset.right
        delta.height += self.contentInset.bottom
        
        return delta.rounded
    }
    
    var contentOffsetDeltaValue: CGFloat {
        switch self.paginationDirection {
        case .horizontal:
            return self.contentOffsetDelta.width
        case .verical:
            return self.contentOffsetDelta.height
        }
    }
    
    var reachedPagingThreshold: Bool {
        return self.contentOffsetDeltaValue <= self.paginationThreshold
    }
    
    var hasContent: Bool {
        switch self.paginationDirection {
        case .horizontal:
            return self.contentSize.width > 0.0
        case .verical:
            return self.contentSize.height > 0.0
        }
    }
    
    var hasBounds: Bool {
        return self.bounds.width > 0 && self.bounds.height > 0
    }

    // ----------------------------------
    //  MARK: - State Management -
    //
    func beginPaging() {
        guard self.shouldBeginPaging() else {
            return
        }
        
        self.willBeginPaging()
        self.paginationState = .waiting
    }
    
    func completePaging() {
        self.paginationState = .ready
        self.didCompletePaging()
    }
    
    func trackPaging() {
        if self.hasContent && self.hasBounds && self.paginationState == .ready && self.reachedPagingThreshold {
            self.beginPaging()
        }
    }
    
    func shouldBeginPaging() -> Bool {
        return false
    }
    
    func willBeginPaging() {
        
    }
    
    func didCompletePaging() {
        
    }
}

// ----------------------------------
//  MARK: - Geometry -
//
private func -(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize(width: lhs.width - rhs.x, height: lhs.height - rhs.y)
}

private func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

private func +(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize(width: lhs.width + rhs.x, height: lhs.height + rhs.y)
}

private func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

private extension CGSize {
    
    var rounded: CGSize {
        return CGSize(width: round(self.width), height: round(self.height))
    }
}
