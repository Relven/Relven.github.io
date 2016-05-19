<section class="site-overview sidebar-panel {% if not display_toc %} sidebar-panel-active {% endif %}">
{# Blogroll #}
 {% if theme.links %}
  <div class="links-of-blogroll motion-element {{ "links-of-blogroll-" + theme.links_layout | default('inline') }}">
     <div class="links-of-blogroll-title">
     <i class="fa  fa-fw fa-{{ theme.links_icon | default('globe') | lower }}"></i>
        {{ theme.links_title }}
     </div>
     <ul class="links-of-blogroll-list">
        {% for name, link in theme.links %}
        <li class="links-of-blogroll-item">
        <a href="{{ link }}" title="{{ name }}" target="_blank">{{ name }}</a>
        </li>
        {% endfor %}
      </ul>
  </div>
  {% endif %}
</section>
