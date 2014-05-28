---
layout: home
---

<div class="index-content posts">
    <div class="section">
        <ul class="artical-cate">
            <li class="on"><a href="/"><span>Posts</span></a></li>
            <li style="text-align:right"><a href="/about"><span>About</span></a></li>
        </ul>

        <div class="cate-bar"><span id="cateBar"></span></div>

        <ul class="artical-list">
        {% for post in site.categories.posts %}
            <li>
                <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
                <div class="title-desc">{{ post.description }}</div>
            </li>
        {% endfor %}
        </ul>
</div>
