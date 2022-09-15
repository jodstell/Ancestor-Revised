﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated by a tool.
'     Runtime Version:4.0.30319.42000
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On

Imports System
Imports System.Collections.Generic
Imports System.ComponentModel
Imports System.Data
Imports System.Data.Linq
Imports System.Data.Linq.Mapping
Imports System.Linq
Imports System.Linq.Expressions
Imports System.Reflection


<Global.System.Data.Linq.Mapping.DatabaseAttribute(Name:="EventManagerData_01")>  _
Partial Public Class DataClassesDataContext
	Inherits System.Data.Linq.DataContext
	
	Private Shared mappingSource As System.Data.Linq.Mapping.MappingSource = New AttributeMappingSource()
	
  #Region "Extensibility Method Definitions"
  Partial Private Sub OnCreated()
  End Sub
  Partial Private Sub InserttblWeatherInfo(instance As tblWeatherInfo)
    End Sub
  Partial Private Sub UpdatetblWeatherInfo(instance As tblWeatherInfo)
    End Sub
  Partial Private Sub DeletetblWeatherInfo(instance As tblWeatherInfo)
    End Sub
  #End Region
	
	Public Sub New()
		MyBase.New(Global.UpdateWeatherConsole.My.MySettings.Default.EventManagerData_01ConnectionString, mappingSource)
		OnCreated
	End Sub
	
	Public Sub New(ByVal connection As String)
		MyBase.New(connection, mappingSource)
		OnCreated
	End Sub
	
	Public Sub New(ByVal connection As System.Data.IDbConnection)
		MyBase.New(connection, mappingSource)
		OnCreated
	End Sub
	
	Public Sub New(ByVal connection As String, ByVal mappingSource As System.Data.Linq.Mapping.MappingSource)
		MyBase.New(connection, mappingSource)
		OnCreated
	End Sub
	
	Public Sub New(ByVal connection As System.Data.IDbConnection, ByVal mappingSource As System.Data.Linq.Mapping.MappingSource)
		MyBase.New(connection, mappingSource)
		OnCreated
	End Sub
	
	Public ReadOnly Property tblWeatherInfos() As System.Data.Linq.Table(Of tblWeatherInfo)
		Get
			Return Me.GetTable(Of tblWeatherInfo)
		End Get
	End Property
	
	Public ReadOnly Property qryGetUpcomingEventLocations() As System.Data.Linq.Table(Of qryGetUpcomingEventLocation)
		Get
			Return Me.GetTable(Of qryGetUpcomingEventLocation)
		End Get
	End Property
	
	<Global.System.Data.Linq.Mapping.FunctionAttribute(Name:="dbo.DeleteWeather")>  _
	Public Function DeleteWeather() As Integer
		Dim result As IExecuteResult = Me.ExecuteMethodCall(Me, CType(MethodInfo.GetCurrentMethod,MethodInfo))
		Return CType(result.ReturnValue,Integer)
	End Function
End Class

<Global.System.Data.Linq.Mapping.TableAttribute(Name:="dbo.tblWeatherInfo")>  _
Partial Public Class tblWeatherInfo
	Implements System.ComponentModel.INotifyPropertyChanging, System.ComponentModel.INotifyPropertyChanged
	
	Private Shared emptyChangingEventArgs As PropertyChangingEventArgs = New PropertyChangingEventArgs(String.Empty)
	
	Private _weatherInfoID As Integer
	
	Private _stateName As String
	
	Private _cityName As String
	
	Private _weatherDate As System.Nullable(Of Date)
	
	Private _lowTemp As String
	
	Private _highTemp As String
	
	Private _dayTemp As String
	
	Private _nightTemp As String
	
	Private _condition As String
	
	Private _icon As String
	
	Private _location As String
	
	Private _day As String
	
	Private _dayNumber As System.Nullable(Of Integer)
	
    #Region "Extensibility Method Definitions"
    Partial Private Sub OnLoaded()
    End Sub
    Partial Private Sub OnValidate(action As System.Data.Linq.ChangeAction)
    End Sub
    Partial Private Sub OnCreated()
    End Sub
    Partial Private Sub OnweatherInfoIDChanging(value As Integer)
    End Sub
    Partial Private Sub OnweatherInfoIDChanged()
    End Sub
    Partial Private Sub OnstateNameChanging(value As String)
    End Sub
    Partial Private Sub OnstateNameChanged()
    End Sub
    Partial Private Sub OncityNameChanging(value As String)
    End Sub
    Partial Private Sub OncityNameChanged()
    End Sub
    Partial Private Sub OnweatherDateChanging(value As System.Nullable(Of Date))
    End Sub
    Partial Private Sub OnweatherDateChanged()
    End Sub
    Partial Private Sub OnlowTempChanging(value As String)
    End Sub
    Partial Private Sub OnlowTempChanged()
    End Sub
    Partial Private Sub OnhighTempChanging(value As String)
    End Sub
    Partial Private Sub OnhighTempChanged()
    End Sub
    Partial Private Sub OndayTempChanging(value As String)
    End Sub
    Partial Private Sub OndayTempChanged()
    End Sub
    Partial Private Sub OnnightTempChanging(value As String)
    End Sub
    Partial Private Sub OnnightTempChanged()
    End Sub
    Partial Private Sub OnconditionChanging(value As String)
    End Sub
    Partial Private Sub OnconditionChanged()
    End Sub
    Partial Private Sub OniconChanging(value As String)
    End Sub
    Partial Private Sub OniconChanged()
    End Sub
    Partial Private Sub OnlocationChanging(value As String)
    End Sub
    Partial Private Sub OnlocationChanged()
    End Sub
    Partial Private Sub OndayChanging(value As String)
    End Sub
    Partial Private Sub OndayChanged()
    End Sub
    Partial Private Sub OndayNumberChanging(value As System.Nullable(Of Integer))
    End Sub
    Partial Private Sub OndayNumberChanged()
    End Sub
    #End Region
	
	Public Sub New()
		MyBase.New
		OnCreated
	End Sub
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_weatherInfoID", AutoSync:=AutoSync.OnInsert, DbType:="Int NOT NULL IDENTITY", IsPrimaryKey:=true, IsDbGenerated:=true)>  _
	Public Property weatherInfoID() As Integer
		Get
			Return Me._weatherInfoID
		End Get
		Set
			If ((Me._weatherInfoID = value)  _
						= false) Then
				Me.OnweatherInfoIDChanging(value)
				Me.SendPropertyChanging
				Me._weatherInfoID = value
				Me.SendPropertyChanged("weatherInfoID")
				Me.OnweatherInfoIDChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_stateName", DbType:="VarChar(50) NOT NULL", CanBeNull:=false)>  _
	Public Property stateName() As String
		Get
			Return Me._stateName
		End Get
		Set
			If (String.Equals(Me._stateName, value) = false) Then
				Me.OnstateNameChanging(value)
				Me.SendPropertyChanging
				Me._stateName = value
				Me.SendPropertyChanged("stateName")
				Me.OnstateNameChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_cityName", DbType:="NVarChar(50)")>  _
	Public Property cityName() As String
		Get
			Return Me._cityName
		End Get
		Set
			If (String.Equals(Me._cityName, value) = false) Then
				Me.OncityNameChanging(value)
				Me.SendPropertyChanging
				Me._cityName = value
				Me.SendPropertyChanged("cityName")
				Me.OncityNameChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_weatherDate", DbType:="SmallDateTime")>  _
	Public Property weatherDate() As System.Nullable(Of Date)
		Get
			Return Me._weatherDate
		End Get
		Set
			If (Me._weatherDate.Equals(value) = false) Then
				Me.OnweatherDateChanging(value)
				Me.SendPropertyChanging
				Me._weatherDate = value
				Me.SendPropertyChanged("weatherDate")
				Me.OnweatherDateChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_lowTemp", DbType:="VarChar(50)")>  _
	Public Property lowTemp() As String
		Get
			Return Me._lowTemp
		End Get
		Set
			If (String.Equals(Me._lowTemp, value) = false) Then
				Me.OnlowTempChanging(value)
				Me.SendPropertyChanging
				Me._lowTemp = value
				Me.SendPropertyChanged("lowTemp")
				Me.OnlowTempChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_highTemp", DbType:="VarChar(50)")>  _
	Public Property highTemp() As String
		Get
			Return Me._highTemp
		End Get
		Set
			If (String.Equals(Me._highTemp, value) = false) Then
				Me.OnhighTempChanging(value)
				Me.SendPropertyChanging
				Me._highTemp = value
				Me.SendPropertyChanged("highTemp")
				Me.OnhighTempChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_dayTemp", DbType:="VarChar(50)")>  _
	Public Property dayTemp() As String
		Get
			Return Me._dayTemp
		End Get
		Set
			If (String.Equals(Me._dayTemp, value) = false) Then
				Me.OndayTempChanging(value)
				Me.SendPropertyChanging
				Me._dayTemp = value
				Me.SendPropertyChanged("dayTemp")
				Me.OndayTempChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_nightTemp", DbType:="VarChar(50)")>  _
	Public Property nightTemp() As String
		Get
			Return Me._nightTemp
		End Get
		Set
			If (String.Equals(Me._nightTemp, value) = false) Then
				Me.OnnightTempChanging(value)
				Me.SendPropertyChanging
				Me._nightTemp = value
				Me.SendPropertyChanged("nightTemp")
				Me.OnnightTempChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_condition", DbType:="NVarChar(50)")>  _
	Public Property condition() As String
		Get
			Return Me._condition
		End Get
		Set
			If (String.Equals(Me._condition, value) = false) Then
				Me.OnconditionChanging(value)
				Me.SendPropertyChanging
				Me._condition = value
				Me.SendPropertyChanged("condition")
				Me.OnconditionChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_icon", DbType:="NVarChar(50)")>  _
	Public Property icon() As String
		Get
			Return Me._icon
		End Get
		Set
			If (String.Equals(Me._icon, value) = false) Then
				Me.OniconChanging(value)
				Me.SendPropertyChanging
				Me._icon = value
				Me.SendPropertyChanged("icon")
				Me.OniconChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_location", DbType:="NVarChar(50)")>  _
	Public Property location() As String
		Get
			Return Me._location
		End Get
		Set
			If (String.Equals(Me._location, value) = false) Then
				Me.OnlocationChanging(value)
				Me.SendPropertyChanging
				Me._location = value
				Me.SendPropertyChanged("location")
				Me.OnlocationChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_day", DbType:="NVarChar(50)")>  _
	Public Property day() As String
		Get
			Return Me._day
		End Get
		Set
			If (String.Equals(Me._day, value) = false) Then
				Me.OndayChanging(value)
				Me.SendPropertyChanging
				Me._day = value
				Me.SendPropertyChanged("day")
				Me.OndayChanged
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_dayNumber", DbType:="Int")>  _
	Public Property dayNumber() As System.Nullable(Of Integer)
		Get
			Return Me._dayNumber
		End Get
		Set
			If (Me._dayNumber.Equals(value) = false) Then
				Me.OndayNumberChanging(value)
				Me.SendPropertyChanging
				Me._dayNumber = value
				Me.SendPropertyChanged("dayNumber")
				Me.OndayNumberChanged
			End If
		End Set
	End Property
	
	Public Event PropertyChanging As PropertyChangingEventHandler Implements System.ComponentModel.INotifyPropertyChanging.PropertyChanging
	
	Public Event PropertyChanged As PropertyChangedEventHandler Implements System.ComponentModel.INotifyPropertyChanged.PropertyChanged
	
	Protected Overridable Sub SendPropertyChanging()
		If ((Me.PropertyChangingEvent Is Nothing)  _
					= false) Then
			RaiseEvent PropertyChanging(Me, emptyChangingEventArgs)
		End If
	End Sub
	
	Protected Overridable Sub SendPropertyChanged(ByVal propertyName As [String])
		If ((Me.PropertyChangedEvent Is Nothing)  _
					= false) Then
			RaiseEvent PropertyChanged(Me, New PropertyChangedEventArgs(propertyName))
		End If
	End Sub
End Class

<Global.System.Data.Linq.Mapping.TableAttribute(Name:="dbo.qryGetUpcomingEventLocation")>  _
Partial Public Class qryGetUpcomingEventLocation
	
	Private _city As String
	
	Private _state As String
	
	Private _location As String
	
	Private _zipCode As String
	
	Public Sub New()
		MyBase.New
	End Sub
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_city", DbType:="VarChar(50)")>  _
	Public Property city() As String
		Get
			Return Me._city
		End Get
		Set
			If (String.Equals(Me._city, value) = false) Then
				Me._city = value
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_state", DbType:="NVarChar(20)")>  _
	Public Property state() As String
		Get
			Return Me._state
		End Get
		Set
			If (String.Equals(Me._state, value) = false) Then
				Me._state = value
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_location", DbType:="NVarChar(72)")>  _
	Public Property location() As String
		Get
			Return Me._location
		End Get
		Set
			If (String.Equals(Me._location, value) = false) Then
				Me._location = value
			End If
		End Set
	End Property
	
	<Global.System.Data.Linq.Mapping.ColumnAttribute(Storage:="_zipCode", DbType:="VarChar(10)")>  _
	Public Property zipCode() As String
		Get
			Return Me._zipCode
		End Get
		Set
			If (String.Equals(Me._zipCode, value) = false) Then
				Me._zipCode = value
			End If
		End Set
	End Property
End Class
