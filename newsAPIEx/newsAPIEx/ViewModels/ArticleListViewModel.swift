//
//  ArticleListViewModel.swift
//  newsAPIEx
//
//  Created by 전상민 on 2021/07/08.
//

// ViewModel에서는 tableView가 기본적으로 필요로 하는 numberOfRowsInSection에 리턴해줄 함수와 cellForRowAt에 넣어줄 함수,
// 그리고 numberOfSection까지 정의할 것이다.

import Foundation

struct ArticleListViewModel{
    let articles: [Article]
}

struct ArticleViewModel{
    let article: Article
}

extension ArticleListViewModel{
    var numberOfSections: Int{
        return 1
    }
    func numberOfRowInSection(_ section: Int) -> Int{
        return self.articles.count
    }
    func articleAtIndex(_ index: Int) -> ArticleViewModel{
        let article = self.articles[index]
        return ArticleViewModel(article: article)
    }
}
extension ArticleViewModel{
    init(_ article: Article) {
        self.article = article
    }
}
extension ArticleViewModel{
    var title: String?{
        return self.article.title
    }
    var description: String?{
        return self.article.description
    }
}
