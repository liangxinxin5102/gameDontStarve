from django.contrib import admin
from django.urls import path
from app01.views import SendCodeView,RegisterView
from app01.views import SendActiveCodeView,ActiveView
urlpatterns = [
    path('admin/', admin.site.urls),
    path('sendcode/',SendCodeView.as_view(),name='sendcode'),
    path('register/',RegisterView.as_view(),name='register'),
    path('sendactivecode/',SendActiveCodeView.as_view(),name='sendactivecode'),
    path('active/<str:code>',ActiveView.as_view(),name='active')
]
