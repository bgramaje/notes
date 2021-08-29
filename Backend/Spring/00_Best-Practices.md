### 👨‍🏫 Spring Framework
> The Spring framework is an open-source Java application framework, which is based on two key principles: dependency injection and Inversion of Control.

### Best Practices Spring

#### DDBB ENTITIES RELATIONSHIP

By default, @ManyToOne and @OneToOne associations use the FetchTyp.EAGER strategy, which is a terrible choice from a performance perspective. So, for this reason, it’s good practice to set all @ManyToOne and @OneToOne associations to use the FetchType.LAZY strategy