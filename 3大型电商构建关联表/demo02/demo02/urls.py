from django.contrib import admin
from django.urls import path
#引入视图类
from app01.views import Type1View,Type2View,Type3View,Type4View,TypeView
urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/type1/',Type1View.as_view()),
    path('api/type2/',Type2View.as_view()),
    path('api/type3/',Type3View.as_view()),
    path('api/type4/',Type4View.as_view()),
    path('api/type/',TypeView.as_view())
]
