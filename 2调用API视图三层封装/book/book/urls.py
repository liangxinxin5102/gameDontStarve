from django.contrib import admin
from django.urls import path
from users.views import BookAPIView2
from users.views import BookMixinView1,BookMixinView2
from users.views import BookModelViewSet
from rest_framework.routers import DefaultRouter
from django.conf.urls import include
router=DefaultRouter()
router.register(r'apibook5',BookModelViewSet)
urlpatterns = [
    path('admin/', admin.site.urls),
    path('apibook2/',BookAPIView2.as_view(),name='book2'),
    path('apibook3/',BookMixinView1.as_view(),name='book3'),
    path('apibook4/',BookMixinView2.as_view(),name='book4'),
    path('',include(router.urls))
]
