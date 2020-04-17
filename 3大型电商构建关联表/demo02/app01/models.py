from django.db import models
from datetime import datetime
# Create your models here.
class Type1(models.Model):
    """
    一级类目
    """
    name=models.CharField(max_length=10,default="",verbose_name="类目名")
    add_time = models.DateTimeField(default=datetime.now, verbose_name='添加时间')
    class Meta:
        verbose_name = '商品类别'
        verbose_name_plural = verbose_name
    def __str__(self):
        return self.name
class Type2(models.Model):
    """
    二级类目
    """
    parent=models.ForeignKey(Type1,verbose_name="父级类别",
    null=True,blank=True,on_delete=models.CASCADE)
    name=models.CharField(max_length=10,default="",verbose_name="类目名")
    add_time = models.DateTimeField(default=datetime.now, verbose_name='添加时间')
    class Meta:
        verbose_name = '商品类别2'
        verbose_name_plural = verbose_name
    def __str__(self):
        return self.name
class Type3(models.Model):
    """
    三级类目
    """
    parent=models.ForeignKey(Type2,verbose_name="父级类别",
    null=True,blank=True,on_delete=models.CASCADE)
    name=models.CharField(max_length=10,default="",verbose_name="类目名")
    add_time = models.DateTimeField(default=datetime.now, verbose_name='添加时间')
    class Meta:
        verbose_name = '商品类别3'
        verbose_name_plural = verbose_name
    def __str__(self):
        return self.name
class Type4(models.Model):
    """
    四级类目
    """
    parent=models.ForeignKey(Type3,verbose_name="父级类别",
    null=True,blank=True,on_delete=models.CASCADE)
    name=models.CharField(max_length=10,default="",verbose_name="类目名")
    add_time = models.DateTimeField(default=datetime.now, verbose_name='添加时间')
    class Meta:
        verbose_name = '商品类别4'
        verbose_name_plural = verbose_name
    def __str__(self):
        return self.name


class Type(models.Model):
    """
    商品类别
    """
    CATEGORY_TYPE=(
        (1,'一级类目'),
        (2,'二级类目'),
        (3,'三级类目'),
        (4,'四级类目')
    )
    name=models.CharField(default='',max_length=30,verbose_name='类别名',help_text='类别名')
    code=models.CharField(default='',max_length=30,verbose_name='类别code',help_text='类别code')
    desc=models.CharField(default='',max_length=30,verbose_name='类别描述',help_text='类别描述')
    category_type=models.IntegerField(choices=CATEGORY_TYPE,verbose_name='类别描述',help_text='类别描述')
    parent_category=models.ForeignKey('self',null=True,blank=True,verbose_name='父类目录',
help_text='父类别',related_name='sub_cat',on_delete=models.CASCADE)
    is_tab=models.BooleanField(default=False,verbose_name='是否导航',help_text='是否导航')
    class Meta:
        verbose_name='商品类别'
        verbose_name_plural=verbose_name
    def __str__(self):
        return self.name
